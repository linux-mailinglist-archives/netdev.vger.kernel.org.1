Return-Path: <netdev+bounces-98417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3218D15B4
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97CA11F2244A
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 08:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874A473537;
	Tue, 28 May 2024 08:00:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D37F4EB;
	Tue, 28 May 2024 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883248; cv=none; b=ZIg3LB8I2SQ5fRafOtesLhjLUSPHJMt1/c/PV5UkMbLZ919dS8BCkBPH9D+jVs2xITWkpHTx+b7RVMVZt3TaJD72ZpXgMsragH/S9JI9EyVM0tojWvlWzd8hbUbj6qAZrj279KRpDeLO8sPhkoZBBSxMr6iUcArNwJ00CnzqHM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883248; c=relaxed/simple;
	bh=RhkyQHlPiLOYRbbvzIhnzQnF0kVY+sp1lf/0eKQZ02A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/wYrVT1rgw7NpDr8qxLi7HthaN9zWNaHl8qWvNAqknIWDDSl1RwFKUv0MX0JQ3JM21YbW0ae9UZgqdqWooVpRingVc0qLUekR9ETTgmhGrtS7JqkqAWjpK2xNiTvmVgneeSSjXrXITY2Bw1ySFzKd42dCcEzaHx2N8o4JWLZkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-578626375ffso544410a12.3;
        Tue, 28 May 2024 01:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716883245; x=1717488045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sBo97VWAGrpiLm5u7fP3/zr56EtKoK7rfkuztlc1tM=;
        b=djbQ1dA/mRz/M6W4z2sQLFPtSJIRfhYi7WEU/GBjnhVOPV6DXOalslVMMBal7OzQlO
         ad1ZUdtomK7P2tqqDOzYTnDYplujK+gJCu08bo4PC6KL2lcbB8Uqc1uibhYngRycpBjS
         TNvl5DR3mD/AvQwvvUMrLWCdaLJ82TFHO7MKyYjNVv4MUbHoT40c1CMixAlGmk7w9QLT
         6kdH3fLMyMVLUqOsPTt35sPWlYqu5cliEEpPwCKsm5zbwXG48DdsJTw8zqam0sKFOSdx
         vFZdRkg6eSRymr7uXRhBZsZaN+WnjBbG0KRa6MJUWEDwpQxURHJ8QUOitGktxBngq0ux
         D3yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSfVBmEiP+42NJxvbNcwXpxMXxADAiHWTwvn8ocgmdvorMGveAtsB9ZWNIIhRcwXQZrK+slxFklNsLE/34s+UxlE6XeH58bvcc41tTuLnMf4UK3EFinpAE7fMkryCCpVRpo+y6
X-Gm-Message-State: AOJu0YyRKhiHG4+YnkPGrg8dk5C5O0BcjpozYMbbxwZ+Uu4AafQJpzpP
	DkghvcuR8+gL/6l5QHenLPKJQh2bZynkyWPCbgg50rKFd7xFhWg6
X-Google-Smtp-Source: AGHT+IHBhEweMViPEVUsNOv5RQQCO5KTv8YPwIg/crXJ+w00JOyhT8LyGtDZ4YQlySTM0Ry2l+1PRQ==
X-Received: by 2002:a50:cd46:0:b0:578:50ac:e2e3 with SMTP id 4fb4d7f45d1cf-57851a51f09mr6127404a12.40.1716883244956;
        Tue, 28 May 2024 01:00:44 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5785234860dsm6935875a12.7.2024.05.28.01.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 01:00:44 -0700 (PDT)
Date: Tue, 28 May 2024 01:00:42 -0700
From: Breno Leitao <leitao@debian.org>
To: Gou Hao <gouhao@uniontech.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, kuniyu@amazon.com, wuyun.abel@bytedance.com,
	alexander@mihalicyn.com, dhowells@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com, gouhaojake@163.com
Subject: Re: [PATCH 1/2] net/core: remove redundant sk_callback_lock
 initialization
Message-ID: <ZlWPKkiAU9VV09Kw@gmail.com>
References: <20240526145718.9542-1-gouhao@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240526145718.9542-1-gouhao@uniontech.com>

On Sun, May 26, 2024 at 10:57:17PM +0800, Gou Hao wrote:
> sk_callback_lock has already been initialized in sk_init_common().
> 
> Signed-off-by: Gou Hao <gouhao@uniontech.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

