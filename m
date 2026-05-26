Return-Path: <netdev+bounces-291961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sUCQK+8bFmrBhgcAu9opvQ
	(envelope-from <netdev+bounces-291961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:17:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B4D5DD25D
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF4B2301FD50
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 22:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBFA3C13EF;
	Tue, 26 May 2026 22:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmdFKtU/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD2F316199
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 22:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779833836; cv=none; b=MGUWxPoFnME3A2GpIWRnLTaQ8rsftToYuJXEWfeFviXypQBvIUhTESSRhUrAhvg90C/XDL+5nMdn1moX/YNjyiZyVhmXaaCu6wZdL4xvwEYbH0mSynOf5z+8qtRyosJIa3WBdLNcOB3T/R6MYvoIi/JwhXdhbK8nitlLzP0xVhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779833836; c=relaxed/simple;
	bh=JTIgUv2VftcfYd9l6sEUyQNF6pctIiXtnMj3PVjiB24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abDXJDgj30ZCDHQOEZNtrgyDRMWUuiWjiH1TK4oe0N3jflZEeS8szRZP8u7tDdWikFLoPt2gdQHWic8GqmAWpc4Fp0i4Yrr/xXwfIrNp2THwL8hHfMFO5NYWagKc1ZL0TGvruO1wvnNwvMAcCkELk1GqU+T+iZdVpWUre/vWjw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmdFKtU/; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-c82471904fcso4476990a12.2
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779833834; x=1780438634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gsD4G5vBE2xNc1zGXu5J2WBwni0ku/DrNlLE2mbcMD8=;
        b=LmdFKtU/y7It8S73tlzil6IJ8HsL2ThFJMljHsnBfYvhXxcGkWsP7akkcILwJTHlXT
         z0rT+whld2gIa3PIG3prYdc4BzGae9+gKw83sAqSTEJPO7or26cxQg53w/ulqclLQ7jj
         yutdDIIxSlh48uxQfvPVhSuaJRt4HR+Z6FlgpMiJQfJ9OezB6MfRKfytOL9FyaIQTrDh
         d7uYXiz7P9pnRT+I0qBqGInHis553U/ovzC6Hime/CuKsqchFL74weLM0lSSGaUr5j9J
         L3OtBwVnqWE1PBFbW5HvCNKcSxdS0LSpn03BbEzPQgVtt2on9w8jlx6hBANBUZk6KJpA
         9fvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779833834; x=1780438634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsD4G5vBE2xNc1zGXu5J2WBwni0ku/DrNlLE2mbcMD8=;
        b=XtWcmyGDDNJakYDXZ96ITm/z2fRNUswmxjR92fz2phajKrctfBUVRUtlgiyEtcxjr8
         LJB+ddbt6cqB4DKUbmRhnaBdI4lGp41oC87L5RnHp1lYsC5fDVwWRSkVrY6aHwVT9OhL
         xQOvMFMuppzv4BbJz7szOiI4MxqB1TId5kC6blffKw4IlYLVBlLKSYpuoMz3WrT/0vFe
         gdEKFEXUnA8K1HFOXRZbqDo6imagYCKUGQKGG2yrm/qHHoZNvbRHir+P6i0Pt1MQl4cW
         Aa5Kzd+YEPIO4o1Rc6hii8hDXTctZeAU8GvadOg3owYl33K9AJ8cWOetAecliarBVU9A
         yCpg==
X-Forwarded-Encrypted: i=1; AFNElJ+F6x+CMVyfgPyZoUsJ5X4f9ZctkpIKuHuNQGDRdkr6eyUOjna5S74bAMiGOQ0FYsIodmEEWAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5vF+eIwmna/jSP/B9I8brnfeJBcbC09eAQ6YkA3vD1SZcw0Nm
	c7e0UXGn0Cq4zinzCaA7Vf6hISDPxVp794+dnuOgO7KuDKinJ+4DguuR
X-Gm-Gg: Acq92OEs5GkN3P/RhfC0QeRvyPNCsDYemWq6D2sE4BD3xj5LhjfXl1B/BOQ7je590vO
	+L+se7cJWGfurCROtDAs1G1hzp6jBxLuUlrpsuK0z3eaYSKxZ7bfNMNQBEjMmXgcsm4Cvrct80j
	eEKYPt88BvqdonRpv2Yei9RLNl/68GPBaV+ioKtMbzJFloXWu8C0Vbp2WgPAtTGW3CnNq/Y2qbC
	hyMSKbLDUqbwtd4ZqBkzgPbaebD81P9wov1kqYVNZWNBhvi0FAKtIV20nYt/4LCnlDD7kzHKytX
	mMXeObYOn6GUBTgKeDJgY6XjYlb0VNRo1nG/W/sEJDa0zDPtHV28khuN8z6OQsqEMWMcseIFmnZ
	dQ6TN4Jac54nvEAXbJ+17FfeQWTXnQRxFRG+58otNlaYkVv7YSofFXQ8urUjTmyfUBPHR2GBO6v
	8kGrbYPJJw7zwF+q89
X-Received: by 2002:a05:6a21:a06:b0:39f:1f92:28e with SMTP id adf61e73a8af0-3b32934098amr20456726637.27.1779833834581;
        Tue, 26 May 2026 15:17:14 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4d::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85202a789dsm10541738a12.9.2026.05.26.15.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 15:17:14 -0700 (PDT)
Date: Tue, 26 May 2026 15:17:13 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net, 
	vladimir.oltean@nxp.com, willemb@google.com, ecree.xilinx@gmail.com, 
	jesse.brandeburg@intel.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 04/10] docs: net: update devmem code examples
Message-ID: <ahYbTvIn-DQ4MumJ@devvm7509.cco0.facebook.com>
References: <20260526160151.2793354-1-kuba@kernel.org>
 <20260526160151.2793354-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260526160151.2793354-5-kuba@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291961-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,nxp.com,gmail.com,intel.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,devvm7509.cco0.facebook.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 06B4D5DD25D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/26, Jakub Kicinski wrote:
> Update the code examples
>  - update the YNL sample with the latest(?) APIs
>  - struct dmabuf_tx_cmsg does not exist, use __u32 directly
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

(wondering if a better strategy is to add links to ncdevmem code)

