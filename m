Return-Path: <netdev+bounces-114526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B97942D33
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 13:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF311B2193C
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841FA1AC443;
	Wed, 31 Jul 2024 11:24:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99441A4B2D;
	Wed, 31 Jul 2024 11:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722425088; cv=none; b=n0eN17Nx5xb2emLXEJG4wJfAy34nQm6fVk28pNEYm9AQrsK35gDnLXI4AFYDyG/RnvZvAyf8tJRzq5ZDINv2JdAmJEH23kC66fdFhuwgI3kvCtv9ucptr/LGWMIXozd8Jh8gTLKx1EOp/tmSDRfROFz3NHqtTjQi2b7E3GL/wdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722425088; c=relaxed/simple;
	bh=mJeBt7a2/UvxDMfOzH5vWTzOUni3HatomRBIdB9wi/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTND4mzXepX+jdnorRqR0TMDBKUpEA6DIBPNJPxUQgXoAJzNM8DTdQUKGJ8Tnvq+rvynUgqQdiL/2oI5QvzHmhOF8Qng+MxybpT61vTyAYvLLMw8errU9cEyjivL5fvTkI70y1Oipx2rmluqupK06BeIRDPBBl9ah2iiXaPLfZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5af326eddb2so1481801a12.1;
        Wed, 31 Jul 2024 04:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722425085; x=1723029885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLdtT+A3n0Xb4QYNnqCYFUNPpLz6lnqGJh0VurtI6SM=;
        b=BcAOmxZq+coCFx5i/hvfbIXZr2o3YxQsByGELqynM8Cxc3Ub/6jeRaVXXrHJ5Llh7f
         XMrMchqDn75aMyUis8YnxRX1z9cue0afA1XGvJsLweoc0rps305PWy3hr/gmVWFabG4G
         cIYSg4YUWpX7eIa/NboDNIVHiGKW1GnddI+CCHvrmtDNvtOshkG2coPAve/ob2rk64EJ
         k3sM3ALWdHx6m5AihdVHJZ0ZJnpbbe3qQCvQ//W9CR1CisyXdtqMKQAVO0OwBfL85HUG
         wDjIEynklJfsR0IzOh5HvZxRjxsX1gfM9lAFTSvfHt6IruvkSDV8OskpqzULgzOG+jzw
         +PGw==
X-Forwarded-Encrypted: i=1; AJvYcCWyTx4HRcVP+ErblKnL01VeGpvzazFaTUJAtPUJk+1fTVS/baMvrM6igbtsmSCSEQhDWH+MJPlWqtmGfhuf1sPBzsgf7he85wxxHs82XStigibhQiNbaSq660Ptl3+ct0Wlgpul
X-Gm-Message-State: AOJu0YyzShN1MaexciXMsAaaClZSrmhGgr4i4ssA9WDzjoc3ATL/VdAc
	MBu2Vl9BaoL/fklfFjZ5vIO0SkKLnKYsQTiBSeeNl52aO+8n8KLf
X-Google-Smtp-Source: AGHT+IH8stSlR43duWYMCsiONtPTHYotrqj64a7NDgAzkABfZJYf9VO4vyD185qYfInpZPNjMkgNUg==
X-Received: by 2002:a17:907:1c28:b0:a77:c7d8:7b4c with SMTP id a640c23a62f3a-a7d859161a8mr603669966b.11.1722425084849;
        Wed, 31 Jul 2024 04:24:44 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-114.fbsv.net. [2a03:2880:30ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb9f60sm753040666b.223.2024.07.31.04.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 04:24:44 -0700 (PDT)
Date: Wed, 31 Jul 2024 04:24:39 -0700
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, leit@meta.com,
	Chris Mason <clm@fb.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: skbuff: Skip early return in skb_unref
 when debugging
Message-ID: <Zqoe9/TiETNQmb7z@gmail.com>
References: <20240729104741.370327-1-leitao@debian.org>
 <e6b1f967-aaf4-47f4-be33-c981a7abc120@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6b1f967-aaf4-47f4-be33-c981a7abc120@redhat.com>

Hello Paolo,

On Tue, Jul 30, 2024 at 11:38:38AM +0200, Paolo Abeni wrote:
> Could you please benchmark such scenario before and after this patch?

I've tested it on a 18-core Xeon D-2191A host, and I haven't found any
different in either TX/RX in TCP or UDP. At the same time, I must admit
that I have very low confidence in my tests.

I run the following tests for 10x on the same machine, just changing my
patch, and I getting the simple average of these 10 iterations. This is
what I am doing for TCP and UDP:

TCP:
	# iperf -s &
	# iperf -u -c localhost

	Output: 16.5 Gbits/sec

UDP:
	# iperf -s -u &
	# iperf -u -c localhost

	Output: 1.05 Mbits/sec

I don't know how to explain why UDP numbers are so low. I am happy to
run different tests, if you have any other recommendation.

--breno

