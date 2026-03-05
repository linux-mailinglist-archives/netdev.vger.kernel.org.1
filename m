Return-Path: <netdev+bounces-264210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPWsAJ83qWlk3AAAu9opvQ
	(envelope-from <netdev+bounces-264210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 08:58:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5702D20D089
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 08:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3908230063A9
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 07:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82233339870;
	Thu,  5 Mar 2026 07:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="e7ohBO2E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3413A33A032
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 07:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772697410; cv=none; b=nBFlnEg9HNRKwqoC5jAZNlB7NiO+Qvd+i3us1PPmxpjlR5QRfgZhcYT6aoKPbjIrR7UjtZaqfXsH9sR1QRbSeJsJNQ2rtAZX2CI5CFGfm5dRECQwxye3BxEqU1jGt0dieTOGToSq+Ec6APoa9JN907DLJ1ijtlgaubtW5bCTYOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772697410; c=relaxed/simple;
	bh=mz/EuY8jC9ieYjTjT8XfZfn15rgLMQGbwpMFMcAlAtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ck69916THGmnGRsIdLulDWyMe2+W6m88EPJkRn64EXYFb5z+2W+63GcXTm9np/kc7/dwjgnDzt9/cPsQVoV5x8cETE2voDUud3zxc8vkH0FCjKti6E7vjQ4drGa65rDC/qvTscyzO6oe5ZJQdpl/1P7ORhJ2lXJ/WzeSr5moO5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=e7ohBO2E; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-480706554beso83266365e9.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 23:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772697405; x=1773302205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l5kaz3yDs+eQ3DSayWibzk/nqIRQjOvr8dHk2wAo4yE=;
        b=e7ohBO2EoHi9AUF1ByScMnNHk8aK8R7h37+EEg+EYAw2pTDLpwa5qXzI+XjgNZo5vW
         oCN1/FzT1+P5/bEe7/Rqk8NG6GKlhnGhaT+nT2Ximp2Rw5ehAVs6hNczVJzJhbK2UtKe
         VI/HJ3lzX4G/eM+cddPwkrNT9rtIdF+zZ9pXL0bMGp8173Sv3Zj4q+Yv6eEmu83ZSdJo
         EV/RooVcqE3OT0Ukd8LBHzI3glJnZ6J8qJ2R3tkyHipozJmpCqUTeHxq0jMbXJApxUii
         PNduuJAC9gOQ39xvHQTBgvigVuRqa0FrqTf3Qqjp8Hqm86PxWxpIpNC7B2tac5WcXUGM
         QRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772697405; x=1773302205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5kaz3yDs+eQ3DSayWibzk/nqIRQjOvr8dHk2wAo4yE=;
        b=tbwPOd6w/hN1I6mTP1Tc45L2lZaxo8pnRhL1HrFMk+GZJitgoXqsOcX3RuGkgujAup
         s390H9tlIrgCmRD25BkVefa61Q40mP17uKki1wTiupQOlFzyMkslnvQDEJb2gWrOt93x
         3N44iz99MW6Cg99LBTt+Aovd8XM/wdpitb7H2wQKfucGzmAOkoyVUsXoYvLKYQH/8yw2
         v5mWlRmJ9OYBZ7q5SKZ1x7D/UJylecmXcCSp4D4V7CtUdxJKuqixxmaIo2Cbg4QI9q0c
         tCED14erHXGmFAv5dbExjUFvbhsf/crD0TUsrQxoALurF7BmIALFDBlfJgwiP+ANqR8U
         WPbA==
X-Forwarded-Encrypted: i=1; AJvYcCXIBxybCA4f1kkRbQgrqyqr9v9N845fQAPX/6e8/DFj7jLgDlloPxxuUADu3zVlhnpQrZg3Dh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIKTiSvQ25HaJGCstbp2Zh+MidD5y29FO1CndpwVnDhABC70EV
	HUz3vcH4LOJe2Uz4FeeqC6bOxk6Fl1NHzNancsInsO8GGXJC5G8TZjhzuJu4t6ONitY=
X-Gm-Gg: ATEYQzzts6DlRCgNR4CrR4WyNUpfLqXPXNeY9/poTVe6csLpbSYVWG9quV1PXhqy/M2
	tj1xO/hcrZgaHN3FqL7iOpjgwS1JohU1JMTOOYRO24FsH5hwHrn4iK6R1bkoxKD5xwwnYIPS97D
	ksBnx+mV6ltLPX4R0FhayGCsbjPVLJLl5PKSYL4UDre5EeUxud/IfP5Ejul9hyAIFmwooSQKXW6
	sutY7Wg8u3cGtPFFmDP/0LJQQH7ZCC7mF7gtwfKr+y1CH1jwxbWc5MEXwfUphij3Xy1607SUmna
	kR57N24VKtA3VeOHvcPM+dksp+/p+YlpEv7MSM1ABu5aR0YskDiO46vGo5OXM1w1mGV15Za7M51
	aeFP9XWVZH8bzv0sMCeU5r+OqrDauS9AvmcFWkqdSeGgZNHF2yQvMHFukZ6hVVH44a+6VWGTG/N
	Njrb0FOL9iEtLGaRnU0o0KXDmdDyk3oYTxBX8=
X-Received: by 2002:a05:600c:a51:b0:47d:3ffa:5f03 with SMTP id 5b1f17b1804b1-48519886ca3mr85966475e9.21.1772697404947;
        Wed, 04 Mar 2026 23:56:44 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851acfbd1bsm42090985e9.6.2026.03.04.23.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 23:56:44 -0800 (PST)
Date: Thu, 5 Mar 2026 08:56:42 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Shay Drory <shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next V3 00/10] devlink: add per-port resource support
Message-ID: <np44uzfn6jea56uht4yq4te5clapgj7pk6ygyvkl22wxumwnvt@nrpvzjqzxenq>
References: <20260226221916.1800227-1-tariqt@nvidia.com>
 <20260302192640.49af074f@kernel.org>
 <pmxkihhtsskkwsvdia4z2ss4wxpfc4a4kqxkjv5wk3mwdmpzii@6go7pizk2nst>
 <jssifysprwuafkinc3dguspngxmplrngqxvotp76vhvu4e5lp6@e7mdrjqc5rme>
 <20260304101522.09da1f58@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304101522.09da1f58@kernel.org>
X-Rspamd-Queue-Id: 5702D20D089
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264210-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,kernel.org,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Wed, Mar 04, 2026 at 07:15:22PM +0100, kuba@kernel.org wrote:
>On Wed, 4 Mar 2026 11:34:13 +0100 Jiri Pirko wrote:
>> >>I have a strong suspicion that the user will want to access all
>> >>resources of a device. `devlink resource show [$dev]` should dump 
>> >>all resources devlink knows about, including port ones.
>> >>
>> >>What's the reason for the new command?  
>> >
>> >You are right, one cmd would do. Good thing someone forgot to implement
>> >dump for it :)  
>> 
>> On a second thought, if we merge multiple objects into one dump, how
>> does this extend? I mean, the userspace has to check there are no extra
>> attributes, as they may be used as a handle to another new object
>> introduced in the future... Idk, it's a bit odd.
>
>That's true, the user space must be able to interpret the object
>identifier. So if we extend the command to add more identifiers
>we will have to add the bitmask to the dump request, and have
>the user space tell the kernel which objects it can recognize.
>I was just saying that we don't have to add such attribute now,
>maybe leave a comment in a strategic place for our future selves?

Or, alternatively, we can have per-object dumps as we have for all
objects and command right now and leave things simple and
straightforward? I mean, I don't really see a benefit of a single dump
for more objects :/

