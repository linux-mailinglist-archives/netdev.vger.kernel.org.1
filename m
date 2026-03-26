Return-Path: <netdev+bounces-271843-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CM/DHiDDxGku3QQAu9opvQ
	(envelope-from <netdev+bounces-271843-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:24:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D04832F5BD
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A6068303A3B2
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 05:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E50344DB8;
	Thu, 26 Mar 2026 05:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="WvlT2MTp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FE538E132
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 05:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774502499; cv=none; b=bS+9Qteh154vSI4RMrbX87BCpq6hRbYLmudFBYQSV+7+ltZw9GevjQz4BsN6o/oLDIKr/EYYmzjgdtyQx5xo4+x5WZfH/B/eEoHsqCpa4wAc+RxOvXV/ejot7OWR8PxqPueSmxKcD0eqjk0wabo72XjgPQSZtJfwlwKzkFc5bSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774502499; c=relaxed/simple;
	bh=QWQTUVS0VksjJNqrNhKcAHdZ4dBcoGMDrOMVbGV6A5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5SHhp6gIfgea72t28prnhx6D51JtTQ8tVG++YEUDhEx5WyFBozJYvhOFi9CeRqfC1VOn9io3mlhg+PdvXmWCCZKr7bvcLQ8z9HV3mFYLO/9omjx3hhbyt/wDNhzOI1djtrfB48xfRCiQ3hk8oH4v1yP0ua6TL2ML8QY5N09s/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=WvlT2MTp; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48541edecf9so6380325e9.1
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 22:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774502496; x=1775107296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h6xob+88D6E9GEQn7yU1Wmh2IpOqPRfLWkOOX/qRlp0=;
        b=WvlT2MTppxk+0f5cmkZpeUL32NUuMsIij3ZAd4m0w8V3mfKwAW3xu7FxrsdmBsAZZr
         lU6WiTcD9L2edQuGTNcOrc5qgtUqi8EmQxcqbxMUMgQ8O3R+0CDFYA/YAscHm0Lnljnb
         Sw5L2wg9jCJOfEwHshE7nItWEd8bnyfh+JfjZzzuWJKkxETDT+QRou4BChUA317R+NP9
         JYuMLFnT+aS82iAosOOr+z0HHxe8qef/HrLNTlERQHp0elk6FdTFFmRx9zc9sG1SgV/u
         eC/5bfDOVhqffv/vUgIW/QoYUBuUkUukeM2doWQ/IMFlJ6o8zkJQRT1CLhYq9PPoxWDV
         gUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774502496; x=1775107296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6xob+88D6E9GEQn7yU1Wmh2IpOqPRfLWkOOX/qRlp0=;
        b=Iujw8UpacaXyaAAlhb+N0Y/bapy71ou0qk+Ixf2TbvbKowCUUdyK7IuPURHwbg7Ttv
         A1jfWJjpxTH9pNXbJgYqXWujYt5GqfEthUhGSz+RfMIfe04HvkQFk81hGeiVw0AMkux8
         87mR8W0INfP0wykLurHQ2T0G/8YPIDxPA7adeNyqbo124RB4wi5RkV+5LsFHL3Lr+kl3
         3mjQAvBcEweWMObnY1Se9/Y8npgXjkQQVD50POlzZWXC7xm1oCcct9RKGOu8GErrLoiZ
         Fe9OKJl8kOkZ5KB1qJoT/UN40NjjXbh24ho/PsfmDHp+LIjzm9K4E6XcVJJmMFpcy5YT
         gumw==
X-Gm-Message-State: AOJu0YyCrRLtzgtVAvI+4O0tiKqaxUtzeyR+bOlfEz6mEdxQPYDdhL68
	zVRQCiMr0NbVT/qTbLM7zyIouVomGOKa+1D3orW/6viOG+JrJM7Hx0LfQ4SwqxubMrY=
X-Gm-Gg: ATEYQzye8PEQoU5w/5CiIobVusnjjRcEUXchVotFaZcRLIeURLoXAzk7hjx+SuqBoxR
	2vgJUJwraytDWiLGHjZnBAcaCIwGTnG7DLpRTwj1cs+I7efNsGr4+xyVtlfyYEg1VlGvpMT9ghA
	gG466j/Pt2ZzHE4eWzlbbDSEJu+YDRU8siNSLcsVo4RQnHSR6GduTCGp3OkPQPPHe1mltU6dHWd
	xZVPXzkuoPa1CxjhllrEM7CNbS38AshCpA4/K4yv3fsOMmkJ5jGwONbJOZ1LiCIHH9niCQ9ssfA
	triLHDBj+YO+i58cMuOCJKWEUg9R79MwGTjbJh3D5tcqxu+v6deFuOCxwNc5r8MdNWk1vV2e1l9
	Jckx3n35r4QXnnQQByDwjL0xicGUxuRhXyZ6dRsi9m6mkDapMzhVzB/DA06JtKcY/TDQc37HAgp
	u8c67p1lp3sWFsX4dKn+mITaoDfUMAFy67V2s=
X-Received: by 2002:a5d:64e6:0:b0:43b:45d1:f438 with SMTP id ffacd0b85a97d-43b88994ef9mr8986926f8f.3.1774502496388;
        Wed, 25 Mar 2026 22:21:36 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919e7372sm6396013f8f.34.2026.03.25.22.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 22:21:34 -0700 (PDT)
Date: Thu, 26 Mar 2026 06:21:32 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, edumazet@google.com, horms@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, Michal Schmidt <mschmidt@redhat.com>
Subject: Re: [PATCH net-next 1/2] devlink: unify devlink_shd_get_priv() into
 devlink_priv()
Message-ID: <npyzzb7a5rvpy3sb6tewabivvje2cqvr625y7tdgfctvqoeagj@42h6ru4dqwak>
References: <20260325063143.261806-1-przemyslaw.kitszel@intel.com>
 <20260325063143.261806-2-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325063143.261806-2-przemyslaw.kitszel@intel.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-271843-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,intel.com:email,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 3D04832F5BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Wed, Mar 25, 2026 at 07:26:52AM +0100, przemyslaw.kitszel@intel.com wrote:
>Unify access API to shared devlink priv data with normal devlink.
>
>Thanks to Jiri Pirko, we now have ability to create shared devlink
>instances [1]. Introduction series have added usage of those for mlx, but
>without priv data attached to the shared devlink.
>
>Current API makes it possible to access shared devlink instance's priv
>data:
>
>	void *devlink_shd_get_priv(struct devlink *devlink);
>
>but it is easy to forget (especially during rebase from "before shared
>devlinks" era) and call:
>
>	void *devlink_priv(struct devlink *devlink);
>
>which even has the same signature, so it's hard to catch the error.
>
>New proposed API unifies both calls into one, without any increase in the
>observed struct size. (Alternative could be to store additional pointer,
>set during devlink_alloc).
>
>Unexport the less convenient API call.
>
>[1] commit 411ad0605875 ("Merge branch 'devlink-introduce-shared-devlink-instance-for-pfs-on-same-chip'")
>[1] https://lore.kernel.org/all/20260312100407.551173-1-jiri@resnulli.us
>
>Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

