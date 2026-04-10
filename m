Return-Path: <netdev+bounces-277497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBNDL5Mx2WkOnQgAu9opvQ
	(envelope-from <netdev+bounces-277497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:21:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B713DB01E
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B52633003701
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DD1224B1E;
	Fri, 10 Apr 2026 17:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ht9xxqQM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3409D3DE438
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 17:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775841677; cv=none; b=l/2P5WF3QfGVpEiFUTwow2RiKqGFy47gH2bPlVaw6k7DQtttqWvkOPXYx5xyAttnqYIpiIN8ZQFXct4WyMtmlvFR5EZ7ldF80gglYzjgqK4IeMr1srHV00SeagTXCYbWhWSMdmfoaNzakl/bv69NDrYhyqK6ZLFRpqTRRsf0eIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775841677; c=relaxed/simple;
	bh=e5lYK1lUQ/L5Rl4sT1OV4Fll/kUwcFB9V9XGt/BjVdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkZJ6KLRW64QrE5/wfBNrDwq9ST8ZnsxFokfr3IbIloYkCsrWUF9Vr9vrLKnsJAMts0tarR+OkU306slRipGEhPlb/uR0h+cWN0VLAla3u9NWGng9XuWBLswfpKEy0Rx229mzS8LxKMQKMXhCfBMLY9bEDhtyfIFsOJqFEVe62I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ht9xxqQM; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d572f7437so1591959f8f.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 10:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775841674; x=1776446474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=88cVBJSy5xjvF8idw86suZ9TuCLtWrP4zxfv/X+nnUo=;
        b=ht9xxqQMDwX2q8PTmKKT5f7zBwxlazJUr0fduHyFe7jBUcZ5pQG/sXDXHExJ/sxZdJ
         68xP33sBAyd6DFJDRRknja0X+yZmBlXPaJHuc9eBu+X5eyaESGCbmTRt2ToPC04axXlf
         vP0A9LnZZW3TzGKGjNnCreMX9QrPo5pYKArtqxYcm4l7wf3aGi9GtNzHlu25DwNQHH2i
         oPYx5X8G1KPJKyykczgIqgsQGnNUhVXmMo6MlWvtPr3U0Ltu5HgeVwIhMr1+fdYnQxBC
         2J0AFUcrfopTT3voWQkIoYwE0YJpUH+eK2lBEMFIqo7RkRZeZcsQs/pVOeAzv+aVJWpY
         wQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775841674; x=1776446474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88cVBJSy5xjvF8idw86suZ9TuCLtWrP4zxfv/X+nnUo=;
        b=MdQc9MB7XruiZpAfmUfLd7ZS37xjdqrt79nPDMVI00VyGt7iGOm5JSsOzlrUf9v92R
         XAfSEogQacV6i+RroyQ+UR4x8sGM0ZkDs4ePrxfAZB8xWQKGqEd+8PwBNdeO2Sf2AdRw
         rwvH3HewXoD7lehi1JjhpdP6pseWbijmO44KsUWhWIuolkSEN6vIQt09VzyqF2qQFqgc
         esf/QC45gjlpCE/Pm1Umr8Ci6juqNDP+MhppQKj2cI0ZKOpNdooZyxPI5v+vXIk3DoP2
         uzCGJuxfhfMseN2Sra3o92tnEw+bul4VkTqLTV73cRDlYSJdFcPSgR/ciI6uzj7g3Gq4
         lasA==
X-Forwarded-Encrypted: i=1; AJvYcCUTwqHXWsX1oQR+dBv/GNLBdFoiP8kGhyN8c1E0Yz50nri2xuw2GPqmqvnzcLOS0HgyeuYH7PM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRY1Q53OG9AKtRHLr6UPPDmuZnMXgEc3fILOU4iyVKKSyZQr5I
	SB/F5Z73ogEAMdBqj0jqFWv0fkycrtf8LXlnwD1ag0+VwP+LFVktMja+
X-Gm-Gg: AeBDies2xnD8LQ2U0WUTijo2CP9dBfXs+jwZGw7PUJCVpnJjOWKlQ8U1OXi40sOoMXd
	6V/qW0SfN48tvTI2XKuAYtsm2xyM+uJ2zJGYFEwSirJ/WdMvaxz5L/T0re9sczUAu47l0ZvW+4Z
	fUmzH4U/19Iw9JGad/bkWwxBY8tr/6snxmJNIzmRLlPaS1+CsjuTaxCdPJri2cNP2LHw9rtKMha
	wno3KsayBu5Rnzb34INpV9wKPSxWMl7KQpKuF4PPUkExa3QymbJZM8Fndn3aSSzVHmWe25kbbxP
	bIgUXa2pHuFEEwgWltD5TwTSAdKwNI1Zr8USXpanydTjwg5cfnvcEiUzm4UccMUa+gbc3Hx5BLU
	MSZbq+WJgoJGh8aM+d81Rc9PFppKBDhaWCrKb49nASckNDmojgCycQmplS4HuLcuUi13JUshyCY
	7pr8dZF1O7CW7LT1hqpFM=
X-Received: by 2002:a05:6000:1ac5:b0:43c:fa96:d939 with SMTP id ffacd0b85a97d-43d6429c737mr6098789f8f.22.1775841674404;
        Fri, 10 Apr 2026 10:21:14 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5062fsm8350116f8f.31.2026.04.10.10.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 10:21:13 -0700 (PDT)
Date: Fri, 10 Apr 2026 20:21:10 +0300
From: Dan Carpenter <error27@gmail.com>
To: David Ranch <linux-hams@trinnet.net>
Cc: jj <ve1jot@eastlink.ca>, Simon Horman <horms@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-hams@vger.kernel.org, Yizhe Zhuang <yizhe@darknavy.com>,
	stable <stable@kernel.org>, "Bernard, f6bvp" <f6bvp@free.fr>
Subject: Re: [PATCH net] netrom: do some basic forms of validation on
 incoming frames
Message-ID: <adkxhrzY1T5ZERiq@stanley.mountain>
References: <2026040730-untagged-groin-bbb7@gregkh>
 <20260409190328.GS469338@kernel.org>
 <20260409203235.6b9329f0@kernel.org>
 <2026041026-excuse-slashing-c4ee@gregkh>
 <20260410102827.GT469338@kernel.org>
 <18e3df62-34f9-4de0-903b-19919d7ae2ca@eastlink.ca>
 <2e0f1dca-56dc-d6e6-f4d4-1de3160e0179@trinnet.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e0f1dca-56dc-d6e6-f4d4-1de3160e0179@trinnet.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277497-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[eastlink.ca,kernel.org,linuxfoundation.org,vger.kernel.org,davemloft.net,google.com,redhat.com,darknavy.com,free.fr];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8B713DB01E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 09:38:25AM -0700, David Ranch wrote:
> 
> I agree with John VE1JOT that amateur radio protocols such as AX25, NETROM,
> and ROSE are still very active in the Linux kernel.  This discussion makes
> me wonder how the Linux kernel community judges how "active" a given feature
> / driver / etc is being used in the real world before considering
> deprecation.  If there is an official mechanism to get metrics sent from
> users back to the kernel developer community, please let us know and we'll
> try to get you some one-off or periodic metrics.
> 

We've had times where it felt like users weren't testing new kernels.

regards,
dan carpenter


