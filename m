Return-Path: <netdev+bounces-260243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIiHLaHWnGkJLAQAu9opvQ
	(envelope-from <netdev+bounces-260243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:37:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B98D17E700
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D12AC302A190
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0986836C0B3;
	Mon, 23 Feb 2026 22:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KjYvKm70"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD62B350A3B
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 22:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886237; cv=pass; b=a8Vo+VQqO3E7xCsTZjXlo3fG/VRVoa0fQiFahMnXpAnqaWtQ/DoPD8w0h6rymwLt7q9k7YO3X1BHo0n5SmDagLOFAY54VVlykpzczLNovYqGUdxrxxSCi+1sQYAi1ZsYqsI/1zrbiu9iPid2EORVqadxQCDWTTQT9h6nTHdPT/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886237; c=relaxed/simple;
	bh=SPByhFK0VX6exNFjh1ZMPLtx4CENBsbZgIBlRw4KzqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svw5YicCnAJMxxVvzzckvRnfLQ5iHsPVYllzKhvGvMXtvjqBeI40fxUN8XdsLn1nGDxB8DBIL/PPFpeB1+tKhjoF93/PXAMyGDgZ+V3PexGu0sUQJPOzPSiZF+wPqAk6ekXOL/75q5/lg/u6WJbbPrPuqkCPQ0xQ8IT2++rgntc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KjYvKm70; arc=pass smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a7bced39cfso50111795ad.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 14:37:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771886236; x=1772491036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1vRpWWshjjL9VA+u7vs4zoE3GlWlOc3283ytQw0ic0Y=;
        b=oM4eDpswQuI8LIPMMyIlf0J1591wd3mu9yQLUI+LU0ieS2h0UEkMfKrIYx6Sa/Ucjj
         7bRKdJSXo546astqlr0LifkflpLL/RbyKTRz0VQHpL7/bRjDo7W/D86sDs5vfNuwLRrb
         6aE1EfU/7IUeVII2OL7TMSIt6uknk0IHOlY26WXbDzF5tA8e1H7Eq7cyejYGJVhEqw7p
         PtSmbkH43hXWgKHEWgGQoy32vYvEf2RlHdpYji7LnUb82nQQbDi+bRVb0AE59HFlSGZ8
         zMAlwkqdjhsSAnhZUOSm0rR/+bQ6OLi9HMhV6zKW9g6PVT6Vk6OaSbWS9vfmcRRo54Qp
         XObg==
X-Forwarded-Encrypted: i=2; AJvYcCU4Mf4dUSiIOhW9naU9fueV/SieZ1T7WhhCRjITrfH+N6VGsi4xwi82u3I3MDb99Kf8bEezf6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YweckJTojie8KK7e9Dx9SQ1wNo+nPkTqXpPJNmz1rMJAwhf7bQa
	meRdVkxwFQVysJ12TPkuqOUVFutLnfivwwkoBs0FHBQ70FO6mWKY0ddwjJ+6KxclK9PaEwt5nhg
	B5oq36y1XtQmKtc9Q3R0e/lcxh/N5LfEQqAEReJBeLkHhv3+2YLI2PDkUYXr/W7bzU/H1JBgSfQ
	YTF5AKM4PDLplLr4xR400sZh/sWUAehlNZ/7BtjYjjv6Rg5/W6pUuA2+1dq0rRUGXg4Jabg/5KV
	spp2eAx0Sg=
X-Gm-Gg: ATEYQzz2N7aNQIBu08eFMV/1L087M0z2rpYPmIWvpclc7sCGzdB+mV8Hb1GuV+1TBT3
	RdzIzovmVZ4BFuuWieLUFxoWQVYS/cVjWPJo2zVChqhfWFafzNN938jZxwWMVZBnjz6n7y8BZ3w
	PF6XDNzghlfBfVydx92ilLEesacVfiK90JFIJlFW3PBUtPlYE51k3BJE1RNE8U1+yZAZRACr0GT
	SwybOiBx1pOWJU8Jq8bwmbA0FEcf5Mo4eFiYvCn0kJbyJYfnvTcKLgNlcV57XXezrAG9ZyRroZH
	/NQGswCYgi7rAYNvEpeajqf1VzMDJMTdfvwCXI2yC4GCCZSojACWRcGRrVwF89Q9FSieRRIZkO2
	BdKw/dzn7m9srBJO6TMKTnWvP8JSHNls2nKBRHMp8n5lns/U1H9cjhGZqpl1pLhGEy/67vrMSj7
	FC/X+9v7LB299CeCaKPJ6H1xDJcnt4hnWd4FARc7QreLL+EjQ8VuS/SB71atE=
X-Received: by 2002:a17:903:320b:b0:2a0:c1ed:d0d9 with SMTP id d9443c01a7336-2ad74539d06mr95814925ad.46.1771886236177;
        Mon, 23 Feb 2026 14:37:16 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ad74fd726asm9954725ad.27.2026.02.23.14.37.15
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Feb 2026 14:37:16 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-65a408f232eso6074563a12.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 14:37:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771886234; cv=none;
        d=google.com; s=arc-20240605;
        b=lFSJ39A2J7CD2nWDOMDjBJMVH1pUaaKJ0yKDPy44BiSCRc0laP5NpIhl5STQPndmIW
         frG5bgWkjI7e/lhdQB1tc2SRPQ2+d9tlvbfvZmQjOFwaZDHJ66aaQTkcKivY/orB2m58
         4JxbHaKEq68E1kgvkZ3QkVxN/Mh3o/j2zR5BMBmScnZon/OpXL8wNWjNzLIffF9h3c6G
         vk6JLaT32Fku0Vw7VMw/7nlhDuU4JYmaQj1c+P2gvgC1DmXRKgy+ntCMlioWqRrWA1DS
         QKvBc7nFvHtnpIED4nKlRriovqA3X0pNAEJ5frm/b4buE5uai1aqMEUZQl4lXwSBnTVf
         ndoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1vRpWWshjjL9VA+u7vs4zoE3GlWlOc3283ytQw0ic0Y=;
        fh=h7rKFC2TZ5S7O+B+YBU6VHgfEnIhHkmeEkKv0bUGt/I=;
        b=TZG/7aSIZcCXEqt9+0kxCFlvbwdDYmmAmhVCU1aHLTSXxDa94wDC7Apox/+J+Pfk67
         RLy5+AX3szREtdnSbO1k0yOv9Gv/yKEYDgN8+LRRALvxvQfQ7Os3raPzneF3I9PXfo4g
         JOoWHY3o+U/Hb4ADiwy1k/eRo9BgDVMOrW5m7yMsdai5mI3CvmOnX4svQyLOC6QkwA0t
         7shBdJULPNuBlziCnSHWM/G4nSURyhwAi/RTd08dCtA7fh6iqToDWNWr8eSadgYeE2hY
         Mcb0VuMrGQnKVpbMBf2F/xM1xn+Osb84hk60xFt8dvIhJgloyOYUcaeynn+6MzewtU+1
         tpXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771886234; x=1772491034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vRpWWshjjL9VA+u7vs4zoE3GlWlOc3283ytQw0ic0Y=;
        b=KjYvKm70B4T8cEfjusvKbO8iNWxqnSv1FlQ3Tx+6OmQucxwRK0QEdVqT21j99Wa9On
         bIjKwjUlRHQDb9cXy0LAtR5vllwVwUQiZM4UovfDp56/q1bb5sNF826SQY/ZlWIX6RTc
         aqvUUU3XXWcbj+BxcSzw5Q0RLEhxVtCujJdRw=
X-Forwarded-Encrypted: i=1; AJvYcCU9OYSxOzcuLqJfowz8pvcKpcM3idG4dXTcFEK0raGSy/Qz1jaPs4FRrYLCjlV/GPA7HoGm+7I=@vger.kernel.org
X-Received: by 2002:a17:907:7fa3:b0:b86:edb9:c01b with SMTP id a640c23a62f3a-b90819713bamr511007166b.8.1771886233971;
        Mon, 23 Feb 2026 14:37:13 -0800 (PST)
X-Received: by 2002:a17:907:7fa3:b0:b86:edb9:c01b with SMTP id
 a640c23a62f3a-b90819713bamr511005966b.8.1771886233526; Mon, 23 Feb 2026
 14:37:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223214950.2153735-1-bvanassche@acm.org> <20260223214950.2153735-19-bvanassche@acm.org>
 <CACKFLimX0PPJGeJMG-nycNMufbFsJ4YUTnGbLHC_20xF2n9OQQ@mail.gmail.com> <41c375cd-5c23-407b-9e35-8779f899ad09@gmail.com>
In-Reply-To: <41c375cd-5c23-407b-9e35-8779f899ad09@gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 23 Feb 2026 14:37:01 -0800
X-Gm-Features: AaiRm51FH978UEnMOPWMhbWlWYa1vvoKynsBBwwvikhLCmXLFDNutJOtQBJsiVY
Message-ID: <CACKFLinqWm7wbdgES_gpYNhQiZJ0cv=w0zpra8rXF=3jMQ+BdA@mail.gmail.com>
Subject: Re: [PATCH 18/62] bnxt_en: Fix bnxt_dl_reload_up()
To: Bart Van Assche <bart.vanassche@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Jakub Kicinski <kuba@kernel.org>, 
	Shantiprasad Shettar <shantiprasad.shettar@broadcom.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260243-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4B98D17E700
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 2:27=E2=80=AFPM Bart Van Assche
<bart.vanassche@gmail.com> wrote:

> My understanding is that bnxt_dl_reload_up() is only called if
> bnxt_dl_reload_down() returns 0 (see also devlink_reload()).
> bnxt_dl_reload_up() returns an error code (-EOPNOTSUPP) for other
> actions than DEVLINK_RELOAD_ACTION_DRIVER_REINIT or
> DEVLINK_RELOAD_ACTION_FW_ACTIVATE. Hence, bnxt_dl_reload_up() is only
> called if "action" is either DEVLINK_RELOAD_ACTION_DRIVER_REINIT or
> DEVLINK_RELOAD_ACTION_FW_ACTIVATE. In other words, the code in the
> "default" clause will never be reached. So I think the above change is
> correct but also that the patch description should be modified to
> reflect that this is not a bug fix. Did I perhaps misunderstand
> something?
>
Yes, your description is correct.  So perhaps a better cleanup would
be to remove the default case in bnxt_dl_reload_up()?  Thanks.

