Return-Path: <netdev+bounces-280516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOIcCVgB6Wl5SgIAu9opvQ
	(envelope-from <netdev+bounces-280516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 19:11:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFC84492FC
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 19:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B22843076DDF
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 17:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DF8383C79;
	Wed, 22 Apr 2026 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBo+th1H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1F6382F1B
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776877630; cv=pass; b=QoVzQE+/otgr07ShHMFsOItNpM0oc74nwKOQe8zuH3//WUbW3uu7uMZCnhc0mdPxXkUWQIEm1NzjOlEJHnsvvtVmTjB91PG/t9MdHG4ljFYhglvbs/Yn0raq0mzyUoSeumA3cK2cfgccBDVyuMQbcq/PEox0zkQQzBXUwytzX8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776877630; c=relaxed/simple;
	bh=FPixIxhrPig/IiqM6bhPh/F0pcSNj18lhL/V/CNMZ68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGYRw1/8vi+cCcu0vNlQ3POWvItwx9h7vqrxQ6yl+6R2y1m2tZJ7VOm96L8jY0bKtdpFFA/RWYHITn420HleEBvFlmW3oZMdE5kTwBATqJ1EHKghFiKpasgsPH+JKg3CHS8QZ8TcIN3GvmJMRnFboAvgt3ndFDraf2rdr2OR1wA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBo+th1H; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-797ab169454so75481347b3.3
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 10:07:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776877628; cv=none;
        d=google.com; s=arc-20240605;
        b=EDes5L5cRftkDO/QzbPagAymg6Z5n3NvaiN8TlFWarVZShE5EE1hd3rlVh7YL6H1gw
         UDKppTUe5RVKfv87PtQ5TcHgECaiprV3plcTQoJ3Vvl1AI15yDG7xOcdAlnKW+0kOAGg
         OSwBYQTygNqYUqqbEflbsfTWu5s+iLgLO3xMH9JpmkjBugNBHz2CFmaNCntOkI4jl3pz
         ssEAQ4YFrPq37Sa1VQNFxIPbvd1XdS3CJSPYlSLHeuwFaL8IVmM2G36d6TILIxB5qsV1
         ABt9u5bUy0AgnSCpbqMC/rkhXaic84+gGqpxnpAnLYMbvaC1sTkhLJcKPebcQsEyVxVM
         LjTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FPixIxhrPig/IiqM6bhPh/F0pcSNj18lhL/V/CNMZ68=;
        fh=5/43plroHvErNJh+j1DjC41SBJOM/VGI1bxx3F6YEpc=;
        b=WYzMKAfclkipTslnjvFYYN962qOuyI2lC6H30/Hw+ayAQFkmKtZCi3U/p8IbREapVm
         UB9IGEoR/FL7mzDgGtFCitelIfRVOyouYEUKSoFLh7Pn8SiVfVhtXw1X8rrN3g98EQVU
         MVQzLAtabtSfDv/TsMGYbY6BVsYnuCM7upu9ieD6xqXdjSPr0vfUK8+pcHkiV2Oo8aqi
         w0e/6mTUeSqimZUjioAm/YEPp6AJIdloNqr1+L2IolfYSEgGlULPSPzDyy5hDL2fxXC8
         924sROQgZ+iLQdi3/TNbTXKdKjP/d3fIM3q1en0qMY6x/84FPslCPlMf4GuLHxNQhSqI
         ooEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776877628; x=1777482428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPixIxhrPig/IiqM6bhPh/F0pcSNj18lhL/V/CNMZ68=;
        b=dBo+th1HX6Ki81bzuFsP6Cmu0zpIwe1XJI0BqX8zMq8dfo5ZlZMUYFSgJL/yQ7T/Ws
         w910rYMKfqRxg3c0MUjpsXInfBv/OqHTxDVQA9IK4jz4AseHEzC5T/OwZ5gfFBvRv9Jx
         xFooWuzX5aqeZxPk6rsCTd+jqrcSsqaov+EBAxn/i/buFeWwWSHYAY4qeaw5j+k+a3GM
         09k/pu4Xnv4MUfruTM+HvhCKf3Pz2aab1w8NO2yZ7PvfMz2nFoUTfeNk/dEPXCY2dYIG
         kPWcDwqtbfTO+GOHWOvMC+ytZiVQmk4M49saB9e4rn2RgRsMxb19HR/CdFQI2rNeMfv8
         P2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776877628; x=1777482428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FPixIxhrPig/IiqM6bhPh/F0pcSNj18lhL/V/CNMZ68=;
        b=XdSHtw/ffWQQHGsDs0vQQcPFJ21omqpf9rBkjg/lRVpkuPI2rjXdJU6YmerKRNmub/
         6IveS5T3wFS2jYewGbUgC0jzOHg38xvndl1K8ubCDrbT4wwYuKbkPYnBeilcPFYGthWl
         Wqh1G97tmBtK9jzoqcuAHNMfH/5iE5PfIowG3OJI9Xbl+RbK1rNvzoGr+dJ72e5ytUhY
         6q0GETk/UXSxocA5nJCHtVnUBu4aChqZ3v6z48c1qGatsQ2Z0U0aUuB7BZqW14shRXSd
         v6IImS3ZfgV2fcsaAF8W+ywhUEO3maIyB1zlqKbB9vlOqgTlCOjew+DSQO6AabZ7JKTz
         n5Ag==
X-Forwarded-Encrypted: i=1; AFNElJ/qUrExg9rSScyIT78rAwACB6nLpZCdQREHr2bIjdclL0Am0FNmLcloishLADLoHUd9nANQfSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvtcAu6n930DOkmcFWf/bzE7OQNJSm5ppqCxnPZN4CZWHw9+SE
	gzDQqlzpb5XMH0B9RhUDjSDg8/O9uAF0cx+le+MRc2ZghXVWXs/NMRFnoTpg3b+cN/5gYzr4SOQ
	FmF61ivkqi2orErWRFTfzVnpCghNLO8Q=
X-Gm-Gg: AeBDieugqsG/35PPwXZ+be9fyC+gNBH5bJ65A36qTQff5E/7npf+5q4wLJ6IYPU3u0n
	QuOH2tou5whMfF9QkvTEc9lY+xO7L2PVUebsR0A1GBgFGAD0Qm8S4pPbyZSPZBnexrCMoF12h6e
	GxmrkvvLi+b38aLyfGn5DWU74G8eD/KoadYC1trQMrbUoEby3ocNdHXEeg2v5MqWXACERMZdjLn
	fCrLxX/VIp/nCrtt2F3gxJCMbkX1Bp4Fz2Am0xOnXylDwvwZgVXPdJEwstNVWhTD7ZL4OlmDubf
	0Yz/OA+xVW2byRBCxFLaD2gsz/3rsUU+JsV66miaHsw/HSM=
X-Received: by 2002:a05:690e:dc9:b0:654:403b:6440 with SMTP id
 956f58d0204a3-654403b6530mr7740662d50.7.1776877627775; Wed, 22 Apr 2026
 10:07:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422160342.1975093-1-michael.bommarito@gmail.com> <aej66UTWzQ74dven@home.paul.comp>
In-Reply-To: <aej66UTWzQ74dven@home.paul.comp>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 22 Apr 2026 13:06:56 -0400
X-Gm-Features: AQROBzDyQerIYJyyKMBWKNov1ZNnl-U6PdegiDgXORgyw06owREmKLKMo20mu3k
Message-ID: <CAJJ9bXyoAND+CzLqY=jGWdtaY33jeLWf0sBbj-6OXHyXudqjUQ@mail.gmail.com>
Subject: Re: [PATCH net 0/6] net/ncsi: harden packet parsing against malformed
 BMC replies
To: Paul Fertser <fercerpav@gmail.com>
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280516-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6CFC84492FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 12:44=E2=80=AFPM Paul Fertser <fercerpav@gmail.com>=
 wrote:
> The code your patches modify always runs only on the BMC itself, the
> packets parsed are generated by a NIC directly.
>
> So if anything, the threat model here is compromised NIC
> firmware. MITMing sounds unlikely as that would require tricky
> hardware modifications and if you can do that it's easier to put a
> modified NIC instead.

Thanks for the correction, I definitely got that backwards!

Should I submit a v2 with the corrected notes or wait for any other
feedback / review on patch substance (assuming you think it's actually
worth merging)?

Thanks,
Mike Bommarito

