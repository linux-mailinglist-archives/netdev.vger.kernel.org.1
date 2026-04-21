Return-Path: <netdev+bounces-280132-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKx+FOx/52k+9gEAu9opvQ
	(envelope-from <netdev+bounces-280132-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 15:47:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABD243B7F2
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 15:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E0C1C300B9E8
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA623D6479;
	Tue, 21 Apr 2026 13:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="vo/UrfbJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFBF39D6EC
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779238; cv=none; b=kpXYCdFk5wfwlIVVHTMKLgK/5W6i2SfdUgn2uQIcc7747BSNvDc6MxGm7w2mmRPYTFDNUIw500PlRzFJny3Z3x679IdoxTieyy8+aodyQQ6X7h7w4reC/oIED3BN7HpS1bwssYFKR8a+ZqZl+4q/B2S+ECvMyAz7ZbOGp3kHsdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779238; c=relaxed/simple;
	bh=cPnsphPvzsrHtnf1o8LVbV3zHViJj9GbATvXL4hU8vs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Taj/vEptFId5WGo4S3BuAQsIH9tL7FS3K7SmaPhjYjnhtL7mnsK9Vf1raVylY2wBJMPjBteMLQvHV9QT/vlqZ7qWOCwprVkVGungKjIalsrgkobzVydVBi3NR+ICvmkSTBSK4xu2SpfJYigWIwi96lH4DjwU9JmBY90dofR4/jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=vo/UrfbJ; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-479932ccbc8so2565574b6e.3
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 06:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776779236; x=1777384036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncZC6vM9FFS1oO5nJct87+zQrMiu09u9moJUQ3KEN4o=;
        b=vo/UrfbJvKLB2plXoOTGIHW8XsWBJ/onm4e3AsV0Jeh6iaIETIG1cG8W06GfzZ/lbH
         50aCIeGvZvniGCR7fMpEz/GdjifxuXxFiPP6gO/bvkNFaER05kO1QcBa7OOMiulcxK0H
         WqCchgvPPUKnx8PbQRiPaWqcCsD8V9BkVeZgSWzvtErowJDBV2JIXpVzTsa/JjWA1/i3
         DJng/kIIVcFeHXhRrxeIVdhV+aRyBEBLapNrTXk6wjvdiyUkD3l6Md9GioPd05dYKmTJ
         NP5vYK0LUhP7dW7FlWpBKKTvA44Hv74FwVOCf006ePfm4yYIyQld5qV0eQk4dRikNkma
         JtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779236; x=1777384036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ncZC6vM9FFS1oO5nJct87+zQrMiu09u9moJUQ3KEN4o=;
        b=Zn2yJfJhmv3vdmOKLINF1ZC1SdtHY64wGE2GbFV5cVHszZvRdkXtblXpSt+SLBAJcw
         cPSFARHgItNSZTzNO4DH9XEsNgSfzsq8ZXQd6zhUtxIEUjyY+rIOwihT/zcHKpgk+3Pj
         cFAAB89sZQ8kMNck0Jqcc7+cF4weKTmmca3yJLbz8WF84ie+wvQmP7OcBC6VXhIYVHaj
         Cpg1nb/Buwy4RcTu2xSBmtRYS4H0KGdacaddH913R8qKOkpiIW4H/RcPnNUFACXpI/ii
         89skJrAcPBUhudTlvtC0COeBXkdaVDmV3QzYFMO/DZEHedokk2HxniFanA4OiRlO6EIk
         HwDg==
X-Forwarded-Encrypted: i=1; AFNElJ929oCoGqwJEFnhxsyc4VCquP+aLEV88vrEOIhEPKDIV3bHkMxRZhbPbTBxkBD3qcxzN9wBGSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9vEHI9C+v485aW5cbZhhn+8O/zkR1S+hZAyANYgWVoxt/rZuv
	H7rCDNkTvJ3KfIDb2mH53ZBDxgXmvMsIWZKrledQQe+OIKd/AWF4I7K4G2CZf3Z4RKk=
X-Gm-Gg: AeBDiesUT5SRntyG7PX9WUAVRPZfMRg2V6t29kBA7osQHbo80IZWrHxIi0rpqQt4MwX
	t2d0zA+tD6WKd/qHQFBFN6484xnj0ZJncwK5F79DCLyM1orz8G1TQS9P5LznCImz99EkMUedJqM
	FCn1irohiOklpZdwOa7zFPpF6kEz3nuZbVCRiwcFpQ//g+O7Ero33Ex6izWFINgU1GQ6DdjOR3X
	3c4lX9t/YNfXwYx/f5sMBGmS+t1kjqpiiP7onnAVlQHRspv+NTc0OW3AFFoD3ScuaC9Q4Nfp5h+
	xQ/tpLANJmQexq84pGY4VbDFB7T3As80LFvj1JB8b47sHtS2jZ2OuJ7wQ5yS2Ju1bzVM0z4Cyy3
	HkOnF0/xQrG/bX5Y2SVR0Quc+5RnSIkR7E9j+9c5M/+8howNjs9wmXw0yjd/6JyngPGimnm2ohH
	IDse0Y2zS6L2r/NwZhiuMlViG5GMBVzUVQmXCYtAtOgLmv0A==
X-Received: by 2002:a05:6808:1a06:b0:463:ab56:9ec5 with SMTP id 5614622812f47-4799c8f3109mr9384478b6e.16.1776779236082;
        Tue, 21 Apr 2026 06:47:16 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4799feaabf2sm8808115b6e.4.2026.04.21.06.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:47:15 -0700 (PDT)
Date: Tue, 21 Apr 2026 06:47:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, marcel@holtmann.org, luiz.dentz@gmail.com,
 mchehab+huawei@kernel.org, jani.nikula@intel.com,
 gregkh@linuxfoundation.org, demarchi@kernel.org, rdunlap@infradead.org,
 justonli@chromium.org, ivecera@redhat.com, jonathan.cameron@huawei.com,
 kees@kernel.org, marco.crivellari@suse.com, ferr.lambarginio@gmail.com,
 nihaal@cse.iitm.ac.in, mingo@kernel.org, tglx@kernel.org,
 linmq006@gmail.com, linux-doc@vger.kernel.org,
 linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH net-deletions] net: remove ISDN subsystem and Bluetooth
 CMTP
Message-ID: <20260421064711.04e3e71a@phoenix.local>
In-Reply-To: <20260421022108.1299678-1-kuba@kernel.org>
References: <20260421022108.1299678-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280132-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,linuxfoundation.org,holtmann.org,gmail.com,intel.com,infradead.org,chromium.org,huawei.com,suse.com,cse.iitm.ac.in];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber-org.20251104.gappssmtp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,networkplumber.org:email,phoenix.local:mid]
X-Rspamd-Queue-Id: 4ABD243B7F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 20 Apr 2026 19:21:07 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> Remove the ISDN (mISDN, CAPI) subsystem and Bluetooth CMTP protocol
> from the kernel tree.
> 
> ISDN is a pretty old technology and it's unclear whether anyone still
> uses it. I went over the last few years of git history and all the
> commits are either tree-wide conversions or syzbot/static analyzer
> fixes.
> 
> When we discussed removal in the past IIRC there were some concerns
> about ISDN still being used in parts of Germany. Unfortunately, the
> code base is quite old, none of the current maintainers are familiar
> with it and AI tools will have a field day finding bugs here.
> 
> Delete this code and preserve it in an out-of-tree repository
> for any remaining users:
> https://github.com/linux-netdev/mod-orphan
> 
> UAPI constants AF_ISDN/PF_ISDN and the SELinux isdn_socket class
> are preserved for ABI stability, but the rest of uAPI is removed.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Acked-by: Stephen Hemminger <stephen@networkplumber.org>

Will remove it from iproute2-next as well

