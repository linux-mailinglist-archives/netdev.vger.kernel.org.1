Return-Path: <netdev+bounces-84986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BB2898DC5
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 20:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67B71C23432
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 18:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C00134407;
	Thu,  4 Apr 2024 18:09:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD6C130E30
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712254155; cv=none; b=jGs/mCyxDEPm5XIOzaqD6ofIRi9QlkxY/opHimp2i20OwCMHRrgYSJPPn1UV7Y9Z3Xu1VUwoqBdWN1HDU/mF33EyUScWs9D/jXtVF1yCX2e7saCqoR0nZx2axJNO3Mi4bmCi1KXdpOGtsOZlY+0s4oZyGW6eMBqhoFSJrytp/aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712254155; c=relaxed/simple;
	bh=z2fvJPCsOCCmuVVKaItZmM/ZykI3f6kx0duaw3enIhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iN9xQYlGbOPdt6YTpiWx81CEjRzZ9/2h3VbJjCdb68zTKZLgReYiGFSlLzi1s/MKd7wNX3Y2WeFpJ2krzExBV+t8IX8NXiXDxCUiZh+OE8zple1z4GQnZ7h/WYTvUvluBKNHv9UAo1mmH1+lAxNk1VhGt+YQ1A9bGJM+waPC+M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4e39f5030dso190169766b.0
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 11:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712254152; x=1712858952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjpltsNvXVvSi2WzAqQDHgfOL592Dj9xZNoNmol4ViM=;
        b=BThF20gOnGzax+7Aito4TRFZLXqDb2iif0lVD/JDMEvU+G6lqDGDr8rXGDmP6RmGGf
         fuqMEZuXG4UBhMOy0k4qbnz3watoGqtFpLBXWOJqDFkrfeSkg9ug2BQwE7TJEZbPr7I7
         BlNcwCOd8rurOc8xcr24f3OOOHfj+Wg5Veh/DgUb8I0hEO1ncXYW4/5A7RdhycrS6qw3
         13/FfgYfpx5qWM2Adl6aFiIw3VAGJ3mB+wbT4KZXLSM/fo4HkX1oOHGuL4gPtLf4W4GT
         +gHOEHZhDNc8PuxduvjguNRDm420uYCM0Co19Gbm+PjYNsWHq7vu9TbXikYPY6zjU4Pg
         u/Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVN4gfzkYYR4Nt+r7Xv373DQW9+oWi6BSSqzkzJzaKAzxq9GAqCR0Oeg6s61XWh/0eT/AOg+cGJpPGgqKChGrZWc/t6Ar7o
X-Gm-Message-State: AOJu0YwqnA6guLZvtm200tpGjiotGBnhEgqbNdZREzw9Ymwf/CpLaIeq
	lyvBFmb9u3ujzz4FiRZkUn5EMxyKiEQTXzq2U+kvp4A2G2wX2kXL
X-Google-Smtp-Source: AGHT+IGD3o/5nz5acAFS9rzddt9Gf+OAgCSg2537RKfZfr1XX9k7lnShi7xjI0QYyhNfCBc32JBc4A==
X-Received: by 2002:a17:907:76fb:b0:a46:36ee:cfac with SMTP id kg27-20020a17090776fb00b00a4636eecfacmr260337ejc.77.1712254152184;
        Thu, 04 Apr 2024 11:09:12 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-117.fbsv.net. [2a03:2880:30ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id gy18-20020a170906f25200b00a4e4f129d3bsm6770780ejb.26.2024.04.04.11.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 11:09:11 -0700 (PDT)
Date: Thu, 4 Apr 2024 11:09:09 -0700
From: Breno Leitao <leitao@debian.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: dqs: use sysfs_emit() in favor of sprintf()
Message-ID: <Zg7sxQj/n90al7RX@gmail.com>
References: <20240404164604.3055832-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404164604.3055832-1-edumazet@google.com>

On Thu, Apr 04, 2024 at 04:46:04PM +0000, Eric Dumazet wrote:
> Commit 6025b9135f7a ("net: dqs: add NIC stall detector based on BQL")
> added three sysfs files.
> 
> Use the recommended sysfs_emit() helper.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviwed-by: Breno Leitao <leitao@debian.org>

