Return-Path: <netdev+bounces-270818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAVlB13XwWkaXQQAu9opvQ
	(envelope-from <netdev+bounces-270818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 01:14:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD16A2FF6B9
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 01:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D202D30DCEF3
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08BD17BA6;
	Tue, 24 Mar 2026 00:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTqdUuOl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D825CA6F
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 00:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774310705; cv=none; b=sxwJcbO7TvIPTp+WUvgS+mBR3iqaxgeYEUidW67uI9OqYMDhC95SEcqcp7ARMHBtukOKMuroopJKsT8vQzNtOp2A4Zo6Ync/w7skYhNrq/wus4jdKanxIpcHsHMMw5hmY7bUiIh8nSSJF+6mpofBqkkvXupSEIOTo1/aFLA9Gfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774310705; c=relaxed/simple;
	bh=lwYxwjXMCv2JdT5L0+I8BknONToxoQ0FK5alebO/g5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1+AXnQgDOoDXxLmtXzr257rUcamJmm++JJPeknFuwZjXllwS4h0iwZ00wZzOZHnxzpdOqAO6Lpr9g5cXZc94TFDUO5Lz5wHMY5ycbdIqJH01zywj25Rmu9ZZEzjGaMTQ+0vhvyLrOPHRjYAGp5wV5On7wsLpbKsUwlCeFF/V4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTqdUuOl; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79a8e873ca1so38514257b3.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 17:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774310703; x=1774915503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5m6eGmfe+BCNtopO5PFck4Wvty2fCogCBN1YRsxKpro=;
        b=HTqdUuOlRF06C2PO1moZbEOB9PgziQX+TQgZC33zTFQDrgW7cBNoNF778HfjyAyT98
         D2mZbkOASV0yHK4oMGgdhMSq0XCg7UvtKipozQnB8bwPXRE5IeH9qNpdpf9aucEUT/4W
         IF6qNudyx5hseo08zryNN/AbEco2qj9X6scQ1qdoZtyhLNMs2YiaO9J5lBa1Ra6fBx6j
         Ezoi2tUSTEqzIH0OxY3pZb8HvJRuxo/Cq9v94uRF6PDMMsBNBN4ZIInZjCdeH7tuj3so
         o5PYDl5M6g3V5+1JsxEZ0h6S0rO6wm3nEr7q3IWV2ZwtRRgkLTuco34KMPk3AmT3AkJd
         V/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310703; x=1774915503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5m6eGmfe+BCNtopO5PFck4Wvty2fCogCBN1YRsxKpro=;
        b=f4f8+OpR8uRVnMkd9K+yQwgFobmcHSMQvJ/EdgbkpepD5kQLNgO962QN5DmRo1Nnu6
         W7An3CJDXNzFHvTRE0xtL7x5cUjcnVR7rWsnrLR4D9RHWFE3t5RQwmPomYl4GeSnaUm5
         rkxgscd79FFHgJ4q6hMbhwSP2SpTBVIOq6uoSD/8J18QoJ9XgdDrnM2hOgvqeT8Izn3Y
         qCLjXgBoyIwCnJkRM3Z7E7YljTd4pZYrcLA/6mxltIiJQC9FxK29ABGum9YnmTY2iWxU
         vIT766DluQwWigzU6zYCHykTcuUssKmaAURr/KnNitMXChc/yWSEVx8rkZUcggZ2KOhl
         XCDA==
X-Forwarded-Encrypted: i=1; AJvYcCU+BenhXeieEZFxfvDJlmGkn/a5mnMAiKiz/bXRwTntYkunDZ2lG7bP5PStOECl6LhVnyiVgoc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm/x/qKNtePimt20eg9/Oz9VwAXHMh04cAmclxjcSCyZ56I9vg
	0kyl1oNj60m5nl1ZQIS0RJJ8e1HmJ6vAnL3bs0cANXt++a75o1niOyHp
X-Gm-Gg: ATEYQzxNQqD+WKnNA7YfzhUHmW2skmHGFhDek44CLyOqFWk0ybQZn2jTjbmwJKk/iIz
	kEK7pOQTzeOIx7/BQcKqIuo3d4wA79w2p5pD8csU7Xl6rtVCt8FDLfMRTJoU+ISij9ZbhKaGssS
	1lHP6AmBmoCCtUsr9RbMTWzgavc6ReUIY88GozbriAwicFmmYSc2cOBFxzSAuOVFOJIji+/j/1I
	YSi9QaQyNU+UgCKq96DHOvuDpiDK26f+9PiNS/DdrckPscPyDw24NMHo070uVZy2orvqICQHXz1
	T+FrAmHuUm9+oNZ2fWLHrzxokwa0qOzqvPtBRCO7biR9MPhE7Aga4mlP7T69c9EILVuWt+Ap8C2
	w/prOj23sbZNdjXSf/JTl8czPufNTBXazhAFTpNs0uGwQg8QRu1wappHH+dRyjtrrsTo1ptrFB+
	d8v+3HeDuekw6r2xTrKnEo
X-Received: by 2002:a05:690c:6607:b0:79a:51df:6a3a with SMTP id 00721157ae682-79ac2ee15aamr16525207b3.17.1774310703401;
        Mon, 23 Mar 2026 17:05:03 -0700 (PDT)
Received: from syzkaller ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a903a2d78sm65365037b3.4.2026.03.23.17.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 17:05:03 -0700 (PDT)
Date: Mon, 23 Mar 2026 17:05:01 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, David Wei <dw@davidwei.uk>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net] selftests: drv-net: add missing tc config options
 for netkit tests
Message-ID: <acHVLQA2eIsLuqEU@syzkaller>
References: <20260320-config-fixes-for-nk-tests-v1-1-1e20ec6ddc7e@meta.com>
 <20260321103607.GA74886@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321103607.GA74886@horms.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270818-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: BD16A2FF6B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 10:36:07AM +0000, Simon Horman wrote:
> On Fri, Mar 20, 2026 at 11:08:35AM -0700, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > The NetDrvContEnv env context uses tc clsact qdiscs and BPF tc filters
> > for traffic redirection, but the kernel config options are missing from
> > the selftests config.
> > 
> > Without them, the tc qdisc installation trips on:
> > 
> >   CMD: tc qdisc add dev enp1s0 clsact
> >     EXIT: 2
> >     STDERR: Error: Specified qdisc kind is unknown.
> > 
> >   net.lib.py.utils.CmdExitFailure: Command failed
> > 
> > Add CONFIG_NET_CLS_ACT and CONFIG_NET_SCH_INGRESS to enable these tc
> > options.
> > 
> > Fixes: 3f74d5bb807e ("selftests/net: Add env for container based tests")
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Hi Bobby,
> 
> Unfortunately this does not apply cleanly to net.
> Which breaks CI.
> 
> Please rebase and repost.
> 
> -- 
> pw-bot: cr

Oh, I see now that 3f74d5bb807e ("selftests/net: Add env for container
based tests") is only in net-next, not net yet.

I'll resend with the proper tag.

Best,
Bobby

