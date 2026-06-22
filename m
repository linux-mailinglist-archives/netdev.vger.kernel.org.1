Return-Path: <netdev+bounces-301175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xiXON25uOWrbsgcAu9opvQ
	(envelope-from <netdev+bounces-301175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 19:18:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEDC6B16FC
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 19:18:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=abJcrRzQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301175-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301175-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68B53301FA43
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 17:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4606029B781;
	Mon, 22 Jun 2026 17:18:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A3E33F5BE
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 17:18:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782148695; cv=pass; b=mRUpyAUKL3F7U511WPrqfH7Qr0qZVG3Raykc9rtS2Z+5wQLtYETekQQkXcHXMn2LjIslA9rc8xHoj9lTGejdnubR8Q5jlaUmIKg2F9LD/xYpw97F8hEQVtd4vAJT7Y+3ab2jS8RxiwSdMbSrRTxTLgxYVc5JjfQ4NYkcMc2DH+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782148695; c=relaxed/simple;
	bh=n44ds5wVjTX1XPep05hQMUpPwEWREleHsBxakg63dvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QyRDsuRg3U65VXSTfa2PMBTIaSNyvbztHpcFFynT6GqvHgUegkxkuq87ujPBbeRL8XhZ91Fo1W0kTnovsaXUM6RT/0h/726OYZi5QTj0dcDZ3cg4xBZVJvEmhUnyLELr4x8hS3w64eG6AlSYsKnTisSpIzXjlStwadnm/+JMm0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abJcrRzQ; arc=pass smtp.client-ip=209.85.128.169
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7fffb090ddfso1502617b3.1
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 10:18:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782148693; cv=none;
        d=google.com; s=arc-20240605;
        b=IDNleuzTERacq8X9p3WE4TPtnjLQQ44N8pEeo934/RhklnsmjoGrB2HfD4ayG010Iu
         YLqZ8zZtJro5k3hVXMlgxgLU2CIA0lXZflOn1XvoHkHlDYlEc03/TZ0rVEgbWWAVjOWc
         GccX/c5hpoFhW/IXXvcJE4n4174iFcoEIPpgA0rGasqyQ4IG+h9nryoucc3FlMfs4039
         BgZa4lmILCjwdzV+oadk0XJMlnaGuTF4mOiXVAYPI+NoUNgJTiw1zLXcBPoguxtVz/vz
         q4TzcCOAZwZYN7J/Hd+0T0O3+NvEUrotO8gcD5FTMXLNDclJW+H3gjyPskhecT9fgFAZ
         n6AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n44ds5wVjTX1XPep05hQMUpPwEWREleHsBxakg63dvw=;
        fh=yvrLcZFlO9PdaH0haKQ+mXcCVpmf6VCrEhiUwrzFws0=;
        b=PK/J5E+9Av3R1Llu2sUtVSjJ7sZryN770CZmu5s7gVha9/2zEeexlYhxTOMmLJckDK
         biob6wq5GJYoTOWGsCQl84Dv6QRsgV6Hj46CigMq/ejuayQa8/c2k/TXlyaBaTJODlxE
         D1XlOjeQx/gV9A4sMO17notBj1WcttOhMTxQrj/Pvces3kbitovxkQfMB1v73a7ftTKU
         37KDkPVxLYcGRAt+JaFoqAn+/XI4sGXpFDmbquT+91wu6Jc8XO60nLKqdK46tbierpdL
         s1OCifYu0v89JwCGq8z7MLSrGDi6dsZx2MUtAGAgOWCbn1NyqTm70uKK9YnUWNB0C4XR
         xm0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782148693; x=1782753493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n44ds5wVjTX1XPep05hQMUpPwEWREleHsBxakg63dvw=;
        b=abJcrRzQqHkEj4nhAdP5M5nUn9wLZHN43EMk+00XWJRqdREJhgTo1fDKbCOBOAcWdl
         fVwkOyNMVwSgFN2v6xOnyBySFWpboleNfljD+NLI1T3JyQRstEn6QKiMfiFGGj1abhZB
         qgarO1gujf7uP/xrgA+8AP90UM/nKGfo1+rAOicINhWJ/PX3LMcAebXyWlto2UkK2Z7D
         p1aqlA70EBUViSyohrLtV+Wzk8Wiua1ZV1GzoOAJS44zypLfGMlfnqpvoRBvYuUCH33T
         6g2yZeCd8Wcp9BhkiF3H9LVfWHktNWrhENhuWZgy4SdiTSfeJFIBxIqXYk+AzgJsJEOu
         186A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782148693; x=1782753493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n44ds5wVjTX1XPep05hQMUpPwEWREleHsBxakg63dvw=;
        b=Vnv1QveOoUve9rzo1+cXORy6zytciy1klsMvUDhpJd9Nagf+puqT9sTZ7L2PD21xBb
         5SbfRouzuj2Bh9GIQ/to4CQ1xgjzbx2hBN5e4c4Gek0gB8WfkNxz3mlJpHgKE1os9OTn
         ovxEJEF2YZdzBIM9C4bWZCztsJUwVyU7K27OM0/xZDZVSsnvo4IPUqDyOHuhLpOPZxaW
         X3nOAi7f6baAjfz0H0/DzutDaGKiQlje0/yBwpq9CJ2QTtHuvo3/+MgtSP5WFpG2EBQC
         Gpj8lx44Ai3MzGd4rZzHB0w+OKGTx9Cu89w9k30nGSUUwqwaBal3rXHY5GM4S1QVzMor
         YfkQ==
X-Gm-Message-State: AOJu0YzmajP5lu1vhK3iRa/FWjKXBKZ2iWyLn5WzmfA32PQB502UYf31
	nGKczEVF817k1XHq5Hhm6wR+80jO38pqLNWA4kqO0a/pdG6Lxlg/uGI+izzXYi2Ckzzb8XUZ+Gl
	rHnTgqtRobS4uiMse8tdrTLoFy8ZF2pv6npeBSh8=
X-Gm-Gg: AfdE7cl3MqtV9YuK5IKAFS1XTNG9rXaHs33UeGIzLeh6amjWQInYA7TxsPcJZCiq5rF
	eJB9rp1nM8IiOsb9xlvarZI7Tl7K23D3VdcPwxG6Z81EavLZSUnjwos80MggA6O99cD+Y6xchRs
	UBRE2DJ4dFznPGmhThQsQ2x0ynnl7lYtfu9iNecNECORYSB1GBAzY6bjQ0yYB7rLv/dkDesAlYj
	X/H+omEC8HHknP8m/ZgoqMdWBeFxjxEeyV6eoMqfpsV4zDpsBOP+6zcg1vWX7WyHLFeKOCx
X-Received: by 2002:a05:690c:2784:b0:7ff:5a5:9b60 with SMTP id
 00721157ae682-80672df5e71mr4672897b3.22.1782148692956; Mon, 22 Jun 2026
 10:18:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260621180311.8374-1-rosesophiewright@gmail.com> <20260622081637.172a6bb8@phoenix.local>
In-Reply-To: <20260622081637.172a6bb8@phoenix.local>
From: Rose <rosesophiewright@gmail.com>
Date: Mon, 22 Jun 2026 12:18:00 -0500
X-Gm-Features: AVVi8CeIPCxuMCuz8JwlBPmo0XYulfTexJHJU7W-QO5fCE8ewc09xqTZZQPSlGg
Message-ID: <CAH1jfVRbB8uTt90XT1AVBnSYE8eBzB02hCgV2r92SOXOdyf4fw@mail.gmail.com>
Subject: Re: [PATCH iproute2] ip: return correct status from help command
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stephen@networkplumber.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[rosesophiewright@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-301175-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosesophiewright@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,networkplumber.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3EEDC6B16FC

Hi Stephen,

Thanks for the feedback. I'd love to finish this up. I can apply the
same fix to the other commands in iproute2 sometime after work, around
17:30 UTC today.

Thanks again,
Rose

On Mon, Jun 22, 2026 at 10:16=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Sun, 21 Jun 2026 18:03:11 +0000
> Rose Wright <rosesophiewright@gmail.com> wrote:
>
> > Currently, "ip help" or "ip -help" always returns an error code because=
 usage() is used as a fall through on "ip" and defaults to stderr with -1.
> >
> > This is a minor bug that breaks "ip help | grep" and other scripts that=
 rely on standard exit codes. The fix is to pass the status code as a param=
eter into usage() and change stderr to stdout when needed.
> >
> > Signed-off-by: Rose Wright <rosesophiewright@gmail.com>
> > ---
>
> This is the closest of the three submissions, but there are way more comm=
ands in iproute2
> than just ip. Need to address all the commands. Looks like perfect trivia=
l job for AI
> coding tools. I am looking into it now.
>

