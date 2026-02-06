Return-Path: <netdev+bounces-257561-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJcMEn76hWmjIwQAu9opvQ
	(envelope-from <netdev+bounces-257561-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 15:28:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E86FEE81
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 15:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8AEE30A59ED
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 14:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29A13F0749;
	Fri,  6 Feb 2026 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSofC4LL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA463EFD1F
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770387819; cv=pass; b=WJf8xp/7imsjwTiyMypDTQNeV8aVnkYMCdZPiGoONqhjczfI8M5F7BrUSNFyPBl/Jl/dVLXJdcfwx7xwsbKUqiR4CWG9KjvF/yGRdFwmDGVYd9VndRv8PdNkaSHZ2uVKIXdtGk2vwBuDpsgpixPpr4bHlaZW+VIktH8KCxugtBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770387819; c=relaxed/simple;
	bh=PXickhh4KeKGkqhDKRpUMqyGIAyWhn6PPdKLkeHj/2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgjUOCmyQzl83AzjSXLT3OJT7P5oMCGeUvp5R1QXYKrgyE6W9rnY9SRPnU1OtMA1qHEvajIcc7RKHz2EpZDBvPD1H9VQZTstvJ8cFhZpwQTNtfmsvq4CrAzCxfV2M44UiAePEf2hcdQjQYvNcPFIFfAZHUudvHiWRL5CqPWotn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSofC4LL; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82310b74496so1129488b3a.3
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 06:23:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770387819; cv=none;
        d=google.com; s=arc-20240605;
        b=T8ViLkklWhcWQiBODtxBst1DqmA5T/aW8GYi17Jhor0nQj4s8lktNCgwxTM6mYvnVb
         AFMrImq8+R1HU5dwl2ibOXcIHoz5tLLY5NZG8tD+/XpPi5SRcD1kIFxn4dRigAjz2ikr
         AHZYNGyxOjfD8ixamAM13QKNBxaYXGAliDSrCjA/eM1uCy+47x5NlaLIVUABd2chjkuR
         TijNpqzfdinogVK08zJrPRJnecCeRF1ZHhnf4Aai3yx8ApFF/2ltXRDFS+nueMKSbkyD
         qB3tOx1yMjPEjJg6KCW+EqW5IgZZuWrqyvls5fXdUfr+lDliMcYq+gGY2qjnmacRVdRC
         a++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DHFryuyHzZwQERekEUmI0n3ootzgAcm9TwKz6nk2elM=;
        fh=5UWj3y56ijENpP4ylCYqlILoilsRNFsFYvnpu3QwjVQ=;
        b=IyaKvu/QGysRamkVlnhuRdZDW51z/rewyZrReRMxhNp4G8NAOZdTMN87NgvQ/3gXzA
         m7q7Y/uibQXldKPPP2ZbOKmuUbGhuagZvYDtqjlJ5k/LBDWxyj9wH901b90WN9lemBr4
         sDMzRFU76XCIUv0JdiW2D5mBTaGrs2I/6+DDaEHVGyP4oOIpRkkMCGI8DZGSuH/oqEz6
         IPYsSw75dHCCx+19m1m6r8CmxDB04+U27XDqGmpZhzQbB048ULPjjl3GmxWevqQH7tuc
         k0fyEEpmHsIEbn+Rb6DBtwP5uecrP0if40XMJcsuqDcqw4PjG9yu/EBy5GBbmnBlF3f4
         9p3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770387819; x=1770992619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHFryuyHzZwQERekEUmI0n3ootzgAcm9TwKz6nk2elM=;
        b=mSofC4LL24fjb22BriyIcwBMfMGjC03hx22uEI5jXF0LqvbQGSQXi3etXim1Z6Q2ID
         /34QsdjlviMwIe2VBjc2LIWK/WzB7cxzfMBPMhcUe16I6cvywgY4+5hgW8i1rP2+sEeh
         rSkMJSSvKt13nBD/56Y3CZfLTOg/aAJ2glWK1yNEN8XHSCPYjxt8p0mNPOkTi/0aAf4Y
         RpOA1IqR650kZLJYIWkkH0dLNkYOZi/dZLgaFT4B+NB5pd/X+qJeg8auoOhRebGetvJD
         wxya1dVvksM+/e0ghUkaY+df8LzNZy6keiSK2U8jNwsnbshpWJDSLjAT+S1ZSuLkC9DT
         p4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770387819; x=1770992619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DHFryuyHzZwQERekEUmI0n3ootzgAcm9TwKz6nk2elM=;
        b=ok2t15ZGx9qmImsMw1c6IZaKkuFaDlEEWLXKafxpKxksm1urPc/l6rtZnGusWDFhp6
         UXRwaVko+S1XlnniSz1DvhHvxLnNBVpxeDwK8W7yQW+CBueOa+ilkO+IA8RWYP+2AzWa
         hyKcd6Nw2xhik6cECpKfFFdS0xlwEjb08eJcDrIMSFQsUtQVMVfEsBqtOIRa1E49FJOF
         gOqjktRlHu1AcgC/jGcqH/l5B7CBcjT6Y7uxqBJ6PSTemixPssOVX9+514v1FKPPXlLw
         pPwLlEHVbbuydl80mgnRrY89zdMzWDjnb2ywZ4xk2zHV8R2EXjS78l2B5mZUNgKXbkGD
         F9aw==
X-Forwarded-Encrypted: i=1; AJvYcCVuIP5lC1UgAUkldS96ksBkGvg0vBhSoJ5YaqzQdTGSRl+lW2npvNkFGVYQVcaNXFr5IyZ4VIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa0BXLjGEBgelX1ESsOdvXtIi0pBQUpL1HUGb3ongqdZHot2Bw
	i0NV9Hqlx6KIrW427IXncClLSTEV6rRVgCk6BliYc9ILMQWJgnIESE7mNu1E4ltxqH3gxxU9/ZE
	sn7u7t/jPIxWb5l46iyb8zL5c0VYI/jA=
X-Gm-Gg: AZuq6aKn8ecdW/D4mdOJLJ2LaaFC43tXA6cQOijqsCI1EguV5bCt8CWAcLI2kEx8md3
	lWAnujU9D7rTuTxxD843lOLhiLTCuzDrMXQTOVcjmGz1pQlvV6r8Scw7u8jYkwwJIcyhF/rp8tj
	vPEiejGI0Kv2jA287cKM+yekDSEbuw3qeMFyl+wX4JbmIX6fj1ndWO+iQwPbYr22oyBFJOC0nxT
	YtJwfrEn0VRQ0zz2Z/x4uaVCo7rAebUPYU0umDLwatagorrisyJkpbC3ERIMB6cqw5nSG4LPyKI
	s6PJ0+LYCuPg4sjiLd0Y6pAZeO4AHyDIXIHv3q0bg/DjUUeAiLy8oq0KjQ==
X-Received: by 2002:a17:90a:ce06:b0:354:a332:1a61 with SMTP id
 98e67ed59e1d1-354b3c406abmr1789168a91.5.1770387818576; Fri, 06 Feb 2026
 06:23:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770241104.git.marcdevel@gmail.com> <20260205183127.3a76aca3@kernel.org>
In-Reply-To: <20260205183127.3a76aca3@kernel.org>
From: Marc Sune <marcdevel@gmail.com>
Date: Fri, 6 Feb 2026 15:23:27 +0100
X-Gm-Features: AZwV_QjiIgARPBIF-xbBq24oiPLM-xQSAKEX3MFDTu6GZybs4uktTF2DT9QFvgM
Message-ID: <CA+3n-Tq41i0zdMPkVwyQ2eX81iUvtf8TUBy7gTDeVVNJ_=kSGA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/4] discard ARP/NDP b/mcast/null announce (poison)
To: Jakub Kicinski <kuba@kernel.org>
Cc: willemdebruijn.kernel@gmail.com, pabeni@redhat.com, netdev@vger.kernel.org, 
	dborkman@kernel.org, vadim.fedorenko@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257561-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org,kernel.org,linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcdevel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A0E86FEE81
X-Rspamd-Action: no action

Missatge de Jakub Kicinski <kuba@kernel.org> del dia dv., 6 de febr.
2026 a les 3:31:
>
> On Wed,  4 Feb 2026 23:11:57 +0100 Marc Su=C3=B1=C3=A9 wrote:
> > The current ARP and NDP implementations accept announcements with
> > multicast (broadcast incl.) and null MAC addresses as Sender HW Address
> > (SHA) in ARP or src/target lladdr in NDP, and updates the cache
> > for that neighbour.
>
> Doesn't apply for me:
>
> $ git checkout net-next/main
> $ git pw series apply 1050919

Sorry, stupid mistake from my side.

I saw the failure in patchwork, and I was waiting 48h hours to
resubmit v4 without changes, (now) properly rebased.

> Failed to apply patch:
> Applying: arp: discard invalid sha addr (b/mcast ARP poison)
> Applying: selftests/net: add no ARP b/mcast,null poison test
> Applying: neigh: discard invalid lladdr (b/mcast poison)
> Applying: selftests/net: add no NDP b/mcast,null poison test
> error: sha1 information is lacking or useless (tools/testing/selftests/ne=
t/Makefile).
> error: could not build fake ancestor
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abo=
rt".
> hint: Disable this message with "git config set advice.mergeConflict fals=
e"
> Patch failed at 0004 selftests/net: add no NDP b/mcast,null poison test
> --
> pw-bot: cr

