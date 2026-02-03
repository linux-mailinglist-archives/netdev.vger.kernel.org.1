Return-Path: <netdev+bounces-256143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCi7HgOKgWnuGwMAu9opvQ
	(envelope-from <netdev+bounces-256143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:39:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C72A6D4C65
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 382D23003316
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 05:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC84C36657F;
	Tue,  3 Feb 2026 05:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOz9UEb9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5545535A92D
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 05:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096746; cv=pass; b=dsmaKw1w11TQYS3hlzrFy4JhBBQKYaiu5Hws/GynfJeg8/DLo6VInpNNSFl83pEn+0k9Nv60jkr0Ownbb5PHseTkvbSVfqRuJ/qZk0KOKp5GhwVyJFf0bbbcQ0SAwPnnLCnLnesIuLVMttvG+UFyT/iKJ4wzXp61cVW5aLvGF7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096746; c=relaxed/simple;
	bh=dYc55aK2Ys+CoJKIc2FcVMqcqWjHGtaua3YkKRqFvdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwoC02ypoj91CeSQeNHzFIU9kN1gVVc63hceEyw5QUJeANrf/iIm4eJg95CB33tKOuWa10sp5NLynXB6PI0teLraHU2MhZN8zaoVHSuWeCHPUnc3DrcbcAUdfWDWACo1tAMZfjKeJzNx6PBrVTVTZZIODZI0UFqrOLWdMxgKnSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOz9UEb9; arc=pass smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-8947ddce09fso42666116d6.3
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 21:32:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770096744; cv=none;
        d=google.com; s=arc-20240605;
        b=gqqBrjPGhdUhRsI4k1jqqRHinpxPAWuO0szOenRZtp1Yp/MIxAM+7U29SU8xXewhg+
         eISzzFL2xudwp6q7i4HRQWFAc8nKLEJkaG1nGEAleAjCMwKjO78Oqd/QZ0b5khTooQig
         +yinjb8M/67dteW7Ew8ZJ3z/kZFJqgiJRE0VvobkYhwct9TkQjB4qDCBvdDKCh6g1tQM
         X2CUfcsZcjmxqwqrOyNARiuD0MuNOO70kj46OmlT7bfFpX1Z1OTRCVMVg3qxMZCrki3e
         n42lwoPIQLW/HC7OsfTX6ZEJlpssAWcF1FI2snbhL3QOumaRVmGFP5JL4svoM2JXD2qH
         ctHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dYc55aK2Ys+CoJKIc2FcVMqcqWjHGtaua3YkKRqFvdI=;
        fh=ER+0VxfGbjHt/c1qaFvd56x0d+lYS/DPLQrFTVUZW08=;
        b=NS3A2qwK1emI1IbGT5QLW1cOFMSb26LY/ffubw5Edz6KpU9cR4Mth2pxlF3pNc7kLJ
         JKx9pDuIbAefsufxSCZTTCblBfodGGYwQLSPqUIFG8dQiM75jQPqLGu/NY+1AAcU3XM5
         OtMLV6hkZWp3uLJ0jwu/h3q7S9Q+QzrXpGgqlUeP+DesYBqrm4AuNiBWt6NxNk9R+8yU
         EzBwPfIyxFHNz7WemyfCfFIGCz17c/OnpaUvCRaTMrgr2AUrHsaMcBZ81sN7EUZAtHsu
         u3rCFJ0cv41RknxN2ykJPxuRzLN1Q9WtEDcfRnrgdNqDB6iWO+dLr3oFV371YyhJIhvR
         m1JA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770096744; x=1770701544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYc55aK2Ys+CoJKIc2FcVMqcqWjHGtaua3YkKRqFvdI=;
        b=OOz9UEb9cbwTqUeXKwcj76jfQ2sgzxES4K8SKhZB+qe2wJXWwP8zPsW73zaxr6F4dl
         MZyO83Jg5FZNgbv0ElmmBQIHJgb2YcXrNlYj9AzUpCEgqfpolR7QlvYNaDmJ6TWU8lMp
         XQuGTHgAhQgsRJArtj1ALZQTowdSia58VCa9U/AY0C1e4zZNAwF/bdR6QxH65nnY3ssY
         CjgIGCuMKKUTpBck6PN3gbG0iwPkoNlA9hnLuiCA54N2MD64eaom9eg8oCXpV1KN6Wmk
         4SyhoJKn+foWP7jG+aW5+sZafFGPLh253NP2Dg2gdqY0U3at35N/L6lineSm3yquBfOL
         QY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770096744; x=1770701544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dYc55aK2Ys+CoJKIc2FcVMqcqWjHGtaua3YkKRqFvdI=;
        b=dzdgvJ9/CpsLm30ez1XEUxsBVZFFC9sR/lUNqaLk1SUMosy2YGeAJAqW4+kFRTlRdM
         ClfXCAMAWLmWJDcR/xoFhzYhaYm73J8dxls/4O9lDCqga33r6kaYe6x5/j1QfUGMZ9Hv
         T0cCleF/JSYs8hANYlbCUfqCb7zQhsowb2NNUTy+NfSZPttwkU+QtBC7Lk9crSAaQkNl
         0w88r76VZ7PiAAWjtfkruSdq+eAmA01D18qBx7fjR5FIbtQLOPowoJciWLdlH5Gq2q7t
         E5EXw1BmoWxFFA6tQtcDOq50y4WwCvY7wGmS/p0LHAp0/W2FT2OmQ9y5X0QWMqAlzQfr
         VPtQ==
X-Gm-Message-State: AOJu0Yxpvaw9ZwThrfNmdPQckORn6K7qa9vgjcjUj0Pw3g8MrLUF3+cv
	xMoCyppM7buKAun1BaEJry2j5xjLztQ9wc/ktIpdoQBKNUpOxxYypLS1KJ/l+gqIeWuGsjMqpnX
	AItEhux3X+sC6tVowKzYT4MRt2F+c/z9vBPiWPIc=
X-Gm-Gg: AZuq6aLoo3vJOfNNUOHPxF6SL+yTBFkuS7DuKWsgL0IOE9sDcx9URsVzeZ2ZHUZ2qnf
	MsC2kvkmniZOYdqYZUgPg8hZd8vpBV39WSLTTXIWsjBIZbB6kVmkWUBWK8wkVY/u3IhP3mrwUD9
	wRnbDkeMzL/b0Y1RieTAgCz+O7LyvbJtjKwTfKVjak0QYYX7KLiA9JTvBd7qcWnCw1SpEPWoEY/
	99qpeipLrY/0ZxjH5LRIHKbWsWxe9FcQEa8QgzziRlpqeSuqWCctBtfdG7nuYCUXL5QO+U+pU6M
	Cb9wqlGmsdzPNz5quhpqFz0Lvc0KHT0+sSD8koPKOsNv62E5q4Dh0i5E
X-Received: by 2002:a05:6214:470b:b0:895:c80:75af with SMTP id
 6a1803df08f44-8950c807c86mr69379846d6.34.1770096744093; Mon, 02 Feb 2026
 21:32:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131012119.25863-1-enelsonmoore@gmail.com> <20260202182054.0a755aea@kernel.org>
In-Reply-To: <20260202182054.0a755aea@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 2 Feb 2026 21:32:13 -0800
X-Gm-Features: AZwV_QgV_msikh5HonM1cJtdsRkIzDuJpsKAGI_EekNKv5o41uWhQZeoQslY-3U
Message-ID: <CADkSEUiAvv6eHEcLBkHRW8KFqSgcxg46+1BE25T50hT6ZkGbbA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: ethernet: pcnet32: remove VLB support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Don Fry <pcnet32@frontier.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256143-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,frontier.com,lunn.ch,davemloft.net,google.com,redhat.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C72A6D4C65
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 6:20=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
> On Fri, 30 Jan 2026 17:21:19 -0800 Ethan Nelson-Moore wrote:
> Unless the maintainers acks this I think we should just wait until
> we can delete this driver completely. Unless this unblocks removal
> of some VLB-related APIs (which I wasn't able to spot..)

I don't think that's going to happen anytime soon, given what people
have said about its uses.

FYI, as of 6.19-rc8, the driver works with KVM's emulated device
(Advanced Micro Devices, Inc. [AMD] 79C97x [PCnet32 LANCE] [1022:2000]
(rev 10)), well enough that web browsing works fine and it can
download at several MB per second (multiple large files at once). It
has random short stalls (of a half second or less), but that could be
due to QEMU emulation issues.

Ethan

