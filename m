Return-Path: <netdev+bounces-282334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IUJEpjc8WnKkwEAu9opvQ
	(envelope-from <netdev+bounces-282334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:25:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D121E492CB2
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79B3F302FA37
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C093D092D;
	Wed, 29 Apr 2026 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVEZmKj2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5512F3D3482
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777458305; cv=none; b=f5da4AQlFl7wEf7C/ErTuKWDs3Pro/j/MoUK/swDP2ytKJJ20tXNHrdWrHxipzgmycA0os1VHRM6wrjANy2unDfe9ccXGpPDR/CbAc8eW0UDD8aThDzPZpyMHOo7Qn6FK1zE3ninM7htv7GL5mTno/EFSw9sEGb0n1x1Fhlx980=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777458305; c=relaxed/simple;
	bh=CdrLN0lDSJ+qLPLvLukQjHPxitbeiKWzUTVI2etEt4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieySuulbqYuySnusgxFxgQd/BhxX3aUwvpuLZFewPREzw2NH0cg4VYTYw+lIEAMZkIteMbPIpWkERv2s5M4U3JRM2g3qpisH3INL5+CzpzmeZybKvY0O0qHf2AUhtFUeOE1puZwgnc8p1ruWxkE0OSzwZlkaIDtxavIf8wBgwqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rVEZmKj2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488ba840146so110787125e9.1
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 03:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777458300; x=1778063100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kGaorEyZYwXUrpqtvF2wYxBfD162OIEpEP/P+Q+kjPA=;
        b=rVEZmKj2VsWPCvddA8XUWLrhmR6+K5O49dRH0Z66+hvjBAdoh4k4ZOdT6OiHxHlRa4
         SCZIAfhMaJ/n0IFcey01+cl1EJNaFwutrtvYRYTYvU1dq1eCv35f+cRU6pcb4v7jJu22
         6KQfjf5RJyN4ip7x1Y2lgK1xAGaGVik/yhDOg+SU0zYBoX6exntqy+SHzo+CFeq0L+Ws
         hNV46f6vPPWxgn49MehDXrfM7KeYysHv2QhJBF6EWkj3K4wlEC/q7jh75PKZPQudxLZv
         A3UqMHTMcGiHFECdcOzuwh8t07S8aY1prV9fIMmJqo/247pV1nBFcUswGdwXTZJtDgtO
         KKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777458300; x=1778063100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGaorEyZYwXUrpqtvF2wYxBfD162OIEpEP/P+Q+kjPA=;
        b=FA3TRSleWXqNVdYOpcTQmkj/b3qPulm1NzxiZx08qOUeeOMuTv+y36FKXFvdnQhgeJ
         +859ASqWSKDhHFCqT/w1CbXTIa7DFekkfqCX4LnyB0asm4pvXGE9wMP4Gi6VY0FOSNZy
         yZ5MKYidm9iHrzq5yUoA0j2cP+SUCCv5hq7Ar6MsyjZYzoIhLUQxx9wZmyXCyumxOwwu
         fEGi4MAVFeyCQB84wTKEfKmuzczK8koWYN8aJA02BrtRe1e7EnYnqwZLYm7CfQ+bbKaY
         VOFcvO+RR9EYU4+/di72jq2QF/hhShEHt2IKgVgO/WVHeloxEnOetnf8QTwDOPtpdwGu
         otbg==
X-Forwarded-Encrypted: i=1; AFNElJ9dzLP4GzfaeZfJ9QX6p+ran93CefIiQBnfpP6R/iXhrFyT0VZrEaTPqhB321rxpoUVmF43BAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1EZOc13Pj7UivQDbaYTjzZbBAbNo5WC0d1f0r+YjforwWs6Qb
	TTbA46vaLp76hht4DRUfuSTPMhY/TYa+lGsDgYSR3FSIxi8E9mkmE2XO48Uuwg==
X-Gm-Gg: AeBDieuo2qxKzUGzk3uTzqifkqUkobxV1zxN2CrR3k8WgN4g2ODR0bBo91M268mfpQI
	vQ+q4x35FUeKdEfG3+nDUaK1PY+xYrbjhTM+DXkaKfH9HZo0BdmBU+nKVij9U9U2adPfeLK2WuT
	nTY9x9IPIC7VmoDMXVEFuMSJa9s46JlOJi9a79eSpAZqsJ6K3XeHLAVDi+/WNYxEDaU9TLwHk3+
	UX+izeAT1VE03X1Yd10Sib14vEz6n11k0NP5HCkccseW1icNBfK63ESESxe+9vkBpkWukqXcJkB
	qb9LaSp01iTo0nXeFOunEs9zLQf6eE60cCvV9C4dwd6NTobOIT+UpYulmaC/rNVM8QAfqSMoFmN
	sau+FTDyTvPhZJRG3hOkCEJ5+OqdW4O+Dy2T/KtYzI9Iw1fQ5YBzAtvYA7X30naQcXlUOv/IMor
	/5inATKcRxhW7WOnjA35s3az0/YsPMWnA+XNuuiPVl
X-Received: by 2002:a05:600c:1c20:b0:489:1aed:1658 with SMTP id 5b1f17b1804b1-48a77b241admr115999145e9.23.1777458299919;
        Wed, 29 Apr 2026 03:24:59 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7b9116efsm18185095e9.4.2026.04.29.03.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 03:24:59 -0700 (PDT)
Date: Wed, 29 Apr 2026 13:24:55 +0300
From: Dan Carpenter <error27@gmail.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jakub Raczynski <j.raczynski@samsung.com>, netdev@vger.kernel.org,
	kuba@kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3 net-next] net/intel: Replace manual array size
 calculation with ARRAY_SIZE
Message-ID: <afHcd7BfFx8WzpMn@stanley.mountain>
References: <CGME20260428103757eucas1p132f3f1123fae21d596a51cbdce72c931@eucas1p1.samsung.com>
 <20260428103653.3539239-1-j.raczynski@samsung.com>
 <ef61b770-ebf4-406a-90a0-8a49aba02aee@intel.com>
 <afDL02Z4QV6G0UxF@stanley.mountain>
 <b0a706e1-2494-40b4-836f-f5d32c6b0fef@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0a706e1-2494-40b4-836f-f5d32c6b0fef@intel.com>
X-Rspamd-Queue-Id: D121E492CB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-282334-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,stanley.mountain:mid]

On Wed, Apr 29, 2026 at 11:01:46AM +0200, Przemek Kitszel wrote:
> F:	Documentation/networking/device_drivers/ethernet/intel/
> F:	drivers/net/ethernet/intel/
> F:	drivers/net/ethernet/intel/*/
> F:	include/linux/avf/virtchnl.h
> F:	include/linux/net/intel/*/
> 

Fine.  Thanks.  I can add this.

> Perhaps instead of you managing your script, and everybody else doing
> the same, there could be some extension added to MAINTAINERS file to
> encode the prefix?
> 
> In our case, the prefix itself is a message for net maintainers:
> iwl or iwl-next means the patch will go first via our tree, and be sent
> later as a PR for net/net-next.
> 
> Without the prefix it requires guessing what was the submitter intent.

We don't have any intent.  So long as it gets merged who cares how it
happens?

> Most patches that go through IWL receive additional round of testing on
> real HW too, thanks to our VAL.
> Patches that go straight to net are just merged faster.
> As intel ethernet maintainer, I want our code tested more, instead of
> merged faster (in most cases).

All of this scripting could be done on your end.  No matter how many
dozens of people you educate to add a different prefix it's always
going to be less reliable than just scripting it on your side.

Anyway, here is the relevant bit from my script.  The other subsystem
that requires these is BPF but I only send bug reports for BPF issues.
You also need to do a git fetch of all the trees with subsystem rules.

regards,
dan carpenter

# Is this networking?
if grep -q netdev $MAIL_FILE && ! grep -q wireless $MAIL_FILE ; then
    if [ "$FIXES_COMMIT" != "" ] ; then
        if git merge-base --is-ancestor $FIXES_COMMIT net/main ; then
            TREE="net"
        elif git merge-base --is-ancestor $FIXES_COMMIT net-next/main ; then
            TREE="net-next"
        else
            TREE="net-other"
        fi
    else
        TREE="net-next"
    fi
fi

# Is this Intel Wireless
if grep -q -w /iwlwifi/ $MAIL_FILE ; then
    if [ "$FIXES_COMMIT" != "" ] ; then
        if git merge-base --is-ancestor $FIXES_COMMIT iwlwifi/fixes ; then
            TREE="iwlwifi"
        elif git merge-base --is-ancestor $FIXES_COMMIT iwlwifi/next ; then
            TREE="iwlwifi-next"
        else
            TREE="iwlwifi-other"
        fi
    else
        TREE="iwlwifi-next"
    fi
fi

# Otherwise if the commit is only required in next then put [PATCH next]
# in the subject.
if [ "$TREE" == "" ] ; then
    if [ "$FIXES_COMMIT" != "" ] ; then
        if ! git merge-base --is-ancestor $FIXES_COMMIT origin/master ; then
            TREE="next"
        fi
    fi
fi



