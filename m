Return-Path: <netdev+bounces-286754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBZ0Be8SAmrangEAu9opvQ
	(envelope-from <netdev+bounces-286754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:33:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3BF5138B4
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A05E3034B2E
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEE243E49F;
	Mon, 11 May 2026 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhEKgON8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EDD43DA5E
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518882; cv=pass; b=ksX5JimmJ4nd1Z+gWm8FCcINKTRgdH9anfu6YkitcK+pNUd++DkqAnUNQ4vQviZQylVN0LNcpk2qrMRYiLpQeNTwDKyQxzgBIl3HTd6RDEq4ZIqMisa7w20NXxHzjvlTKboKqzLs5w0Tn+8uENFckbHGhIo+Fwntu0HHfVsGC8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518882; c=relaxed/simple;
	bh=sX76fFKdIdHWcvUPNAk6ORnTk1gk3SV4Auw12s3ZtLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSmWw4ldCHj1QIGMGuDb/VvHfh/goY6JFpUZBlHAqPHA3WQufMT6lA+EWUuiO/y32A+hRfV8aG6JsX0iJSQjtXJoOtEV1zSvaeJzzz02VKPYgoRU+gO7oY+KqKainA4oGXS3qhUcUmgFKmxRS+VnsLe2ryCHf8eqcibvMWo2xEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhEKgON8; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-654672a6d68so4876126d50.0
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 10:01:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778518880; cv=none;
        d=google.com; s=arc-20240605;
        b=CE2T/u+YS42Kktd+SpZIQdoHvVwTS5/zVnCB55uL7mGrkI25GcaaR77eLPSaei7SQG
         TTFZHQudlNynLWr+HVNjnsqryq15AvQTn+QFmmO4yyxNCpn3o84Lx4Kb5wUVeVvFausS
         /4BS2cBCRYAL3MeH5vZIWMps9v+uf7tnyuqmwPvCnsDL9TOQeDBSRJrvVQr7/2XewRR9
         PawKvJ+ShtmxF9hsNUJlwPWHir9OZcjfzb5Oi07e4p5i/VrIGnUufMXBMyIFgbcJQkkb
         +SKYGMaCyY9ZuaPPEJB5rp9lU/vOzrucEnmwfFgnK1amVzl5o/sAu1xYwS88l5H/sfpM
         3gRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3Sg1NMnSjHVsI2sM31JWs4ZSAYtGPCK7HEDDBX1EM78=;
        fh=hpR+OvS7vgsSoTB3qIIhlkaSNms4wHnwFYovtuPOkLw=;
        b=YMBzr+8lSBH0oqmoD3h36I9CeOBv8WK9709BYyDoDTEopJKSw1WktyF+wCzyXNArDO
         DFT9f7SQOclABF1H0blWiURwwZ+mZ1mSxJ72NqfTOnAVAAdIVVQuJSEFn/c6yXKVcuzb
         Ou5/83rhYIfqoPHmL7f44qsoNMCusWHUATf8EwpMGHanY2QyJTws3qHR4CjXV8u+mADZ
         IpnO/vEvUuvF5J48hzH/CxX8iiv/8qPcnla8bpP29J/bQ5M56Y5OdbCMUhXIQfy74CZB
         jinTjP+M7d0cAnEyYYh/F3pdF1ddUDB1pbAUevKVIb8Fc9jWh/O/B61kc/RS5igcvbj1
         wprA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778518880; x=1779123680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Sg1NMnSjHVsI2sM31JWs4ZSAYtGPCK7HEDDBX1EM78=;
        b=OhEKgON80OIy1TrQ5AedbWYWvXJkLRr3IZhNN7DgZU7cyH7SrhWJYPqsAi8s4ebSD8
         KL/hzXxjAXLYxa7zvr+3Gn7GznGYwUbRik3leQDjccaZ5ps4k5p8Oeqa1njPfoxTCIJd
         AuJ3xetEIp7x11qZl++Kw2107ViILLeOq9V+p1b+y7qggJGv2/Pq34esszFLe653MJID
         r5/G03+jQ5GUNz62wHT/0nSpkNOpgNQHd99WbGzd+awgzhR9kGtFZ6ODg9PnS2X8xVzl
         7fOwO0mhLL2Y3G9RjnWjBgsc0TFS+qM+aObqnH9stxbKckFsJCiUe17KjTzjsd3hH7sf
         rS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778518880; x=1779123680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Sg1NMnSjHVsI2sM31JWs4ZSAYtGPCK7HEDDBX1EM78=;
        b=mSeTpMztQkg7++RZryOLYUb4LlrQ24evaPKpDEKuZdu2JxO3RlErKZmgUVzqIoCO+z
         n+y84mqIpF81X8vODoSoiKM+N6pkMPEqURsBStXWYwa3bXdTo40ZYg5kJYxzyAlfVAph
         KOQ8OGL07yuk4he8gKWnx359ylEZ5gLYXjeTK+EIvqU6Xe0nlu7BDI1IkFry56I3oQin
         Cw3qWRYJUscBGGb9F/qgikjwiSSy2Tf45kg0P9/qvQayFyrLr44SSXoHG3pivSE3zajZ
         Z5f8WBekp1svUNOWD87NQfW+iSC4Z/Bii6tZzldBBQPKtDt/vrIMQdWaRvBDyxXITRWm
         9/5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+StZgKcKWdSy08/HlV3lr9RYTL0VoPZwsLYejRchQBtHn7LY6RHcVqcUUl5CkjLWKX2bNinQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyARF1NxXvsor8Ka/F0JUksz+RyJYTOmeef2183q4TQ9/KKdTxT
	xBFV1OKfnlqU8/+nXxyIUfejV4TQBa2BS3fzRY5kapGGdUVxnehC6VEC5HxYJ7Dm466OoYNy6wO
	np7vREElqz2kIy3tk5XzN22NXP4vmO74=
X-Gm-Gg: Acq92OFzeuGllrs1ZTL6YNwiKTpmk0eeGe/OoISCiCZdpKOMYPTPJig4CeFExxGVz/r
	lEJvT+5pPNw+bh1akLct4EsvRsl/BqxNcQMSS/BXR+mwS43ZRz2EqUq0aG8BUwrXn85Q60FAgEI
	Elyu399mJ0VeLC3hf8L0cboCxf88xMwCmzT79rovnbhHePjIqK15NuSorXtyDfCBJJUWGFn0HVL
	kYeKe0F2BnJscBEo03t153mmQqukUmCocIBiyUV8vyv0/tQg5DvNF9pwPN4vJ7GsqP8Np1QC7Pm
	pmK06cbEdsW0cSgM9zGSbV1rLKajTqH6BWFYcb5eVwyVegw=
X-Received: by 2002:a05:690e:4843:b0:654:49e4:ff14 with SMTP id
 956f58d0204a3-65c79994bd2mr19456740d50.37.1778518879990; Mon, 11 May 2026
 10:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1778506829.git.michael.bommarito@gmail.com>
 <490e228dd02983fb1530fb114d4174148f810261.1778506829.git.michael.bommarito@gmail.com>
 <CABBYNZL-f+AzFWdhvLcxdf0oCXbgr3AXqM1W2npOPZEv0gRA6w@mail.gmail.com>
In-Reply-To: <CABBYNZL-f+AzFWdhvLcxdf0oCXbgr3AXqM1W2npOPZEv0gRA6w@mail.gmail.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Mon, 11 May 2026 13:01:08 -0400
X-Gm-Features: AVHnY4JhB2d5GMH88lUH892q70_awbB8KMS0O-OtLSzvuZSSVcwIl7oatzofHYs
Message-ID: <CAJJ9bXxdm6LRW-5a4a1eDyZSQjNkJ4PNF+aERHkHe9EMQFX8oA@mail.gmail.com>
Subject: Re: [PATCH 1/4] Bluetooth: hci_sync: pin conn across hci_le_create_conn_sync
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mat Martineau <martineau@kernel.org>, netdev@vger.kernel.org, 
	stable@vger.kernel.org, Pauli Virtanen <pav@iki.fi>, Aaron Esau <git@aaronesau.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4B3BF5138B4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286754-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 10:53=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Id suggest we dropped the once at the end so just hci_cmd_sync_queue_conn=
.
>
> > +                                       hci_cmd_sync_work_func_t func,
> > +                                       struct hci_conn *conn,
> > +                                       hci_cmd_sync_work_destroy_t des=
troy)
> > +{
> > +       int err;
> > +
> > +       err =3D hci_cmd_sync_queue_once(hdev, func, hci_conn_get(conn),=
 destroy);
> > +       if (err)
> > +               hci_conn_put(conn);
> > +
> > +       return err;
>
> Then we incorporate return (err =3D=3D -EEXIST) ? 0 : err; logic above, s=
o
> I don't think any caller should require queuing multiple procedures
> for the same conn.

OK, good call.  I checked the other 10 callers for
hci_cmd_sync_queue_once and there isn't any variation today, so that
seems safe.

Do you want me to wait another 24-48 for others to weigh in or ship v2 now?

