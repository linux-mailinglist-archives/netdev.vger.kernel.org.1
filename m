Return-Path: <netdev+bounces-278841-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGheILi932mOYQAAu9opvQ
	(envelope-from <netdev+bounces-278841-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 18:32:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C74E1406674
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 18:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5047930063A6
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9D53DDDC6;
	Wed, 15 Apr 2026 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyKO9KY5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D3F3E3D90
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776270659; cv=pass; b=CZPRkIdN68gkckF2ge4mttxlcWJTY+jojbs0x3xJ3JFNO0eN7xr/HR6iVRRm4RLWZrP0Pzgv4A30Dd70/zFWjyNDlhj6+ryk33/w9N00MTfPnCx3/NFVPjhAUqj2Gk5G39xMrTPo6u2TMvbE9phBYUYNwApmTiTE88qrQIcigY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776270659; c=relaxed/simple;
	bh=ICxNKX7qGv+Uf3H7xRWu5USDtER79xTLXqJUWpJ0IX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PiL6mYukYahSwwvFKsglmam82ocD+l5kGSJpIbp5mThCsCZtZhoIurBuqZKWCX2PfRwkRhOyFUBtoWdrDP/eyQONhNtFdNjMUU30q5iiG664XRQ3GkZXzcQ5CfVSzo37YLwPApQ2rO11Z7ViOkix+Mcf/A4iW6vnY96phO0aCfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyKO9KY5; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6501d32b04bso6652671d50.2
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 09:30:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776270657; cv=none;
        d=google.com; s=arc-20240605;
        b=UgGeuAvxb2XicsrqLnFgTsKU9nsA7WQYLRalYNgr2TlhFAfrBVP+5G0mTIEzpzJ2Wj
         jpzEY7n4ee87X4i+3C+FRJr6lMXNTpueICGIalpr3Liz3zrH3dCxa+BKWE07nZpBy01g
         wiirSInEF1P4MGmBsw1UYT/03pa7bzGUHwoftQVDH6dB6Er8uFt9xqLz6McNoGWbbzz/
         h2aBMrIwkRmzuavuTFS7nEf4yL+zUkN/5V0YBJll9QB80o1NJAntbtteTCWTEDfU2P7v
         TSXt/5jYZtwywwVwaCvIe4xvrgf3+jCsuayAhiWX/FT2Sq0LxJdASKU1iOIVd5L2MQSK
         8dmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VBirzWvSR4/3IaGGAFPOCNOFJSU2QwGIXQOrszvzBn8=;
        fh=5Hw8I2eyQCLKhxcr775EYKzmwq4hv53rgd3tsqt3w/8=;
        b=O33E/mtZ7nmpcrmBOP5AJvUaXPxSxxETQ4GqS2fs/xi9mu7VBI6L0lfuVmZbhgIlbO
         0I0rBn8KsU/lFWxXzlIO0PIG50tb6ZQAgFx0S3rW57Hdeet8cgqBEnLRHUdjcTld0/4T
         s80qWgc7GpuovpyL6w9g5uhXgwzj03AhGjm3LhZrtZbmWn4wsPHdSbEJfo18msLNsoRH
         ZzlLUXa1KdScduiz3TepDPVG6Pb6piV8pQ4GXWd/k8J09+uWat4YBMZAKmEp5EoWd3cw
         cNtdRCHecMLj5xYbQsYTkP/a+Hn6SGjYeXEvxEpwBsWirrh880HsrXyXSXhIRmuUx3rK
         BnTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776270657; x=1776875457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBirzWvSR4/3IaGGAFPOCNOFJSU2QwGIXQOrszvzBn8=;
        b=lyKO9KY5xPXj9Kx0yZeRv3Bx6+mqRoqin6KCB6q19bEYuEMAU3v1JWG/LXxNnW6WNW
         Borax+ZrEblfE4NnQ5D9qBCO5f0aRMxTqvGR/NS8ZXstxwP8yJ13QDqH5A3C75OZyqr9
         6VVS3Y1Ngj93hQoaDDeKk4iltjj14Gsu5kWJo48nQQToRiYh+s3/q/3GYpAr4a32oP2f
         grMcxYpMqCRGKLmj1gV4i1rytI+hAi9GG79j6JEtenJBDGzz0CpbilyrgKItN8lqjHt0
         ts2MhMSittHI27QJTgL9lDUSW1fGaUEPJhoR6DWxxwQ41Bf4cpbp97tob0wzpg23cKUU
         JOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776270657; x=1776875457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VBirzWvSR4/3IaGGAFPOCNOFJSU2QwGIXQOrszvzBn8=;
        b=K+AhYyY3/UT9Aa/uypBclBgxRlLSkPpoxdW9uY3YXo+I/KLKLPLxjW9/AhP20Qq7ba
         i6B09g4IJkNKUJhJA8cwni+Rrkj7thyRlPZZD45VylRtlDpWhwVT4tDTdJwwtwDKeB8o
         UybNAboNoWwNcxbjxgfhH9AIgnQyUEzWevOAQ90Ftki1wAfWrPytdlE6NfrE6y6eSeLI
         vCEr/Jij5JPMNy6plw6p09Q/B1BCs6Q+/mBNNkcSCTUTK/TfHWCI0jpLS9hxCknuezbN
         t2mcWjIPeTVCaH3RLWr6QfpD1j3B41dnv3sC5wgD74aoUj39vcNAUVtSQFmO0uGyVxri
         QxDA==
X-Forwarded-Encrypted: i=1; AFNElJ83pecR2yQEtm2+cmDwE8vN84ryJZ1m2XKptRL2V0DMiEB1g/dJsPOfvtIai83ZZxym851R1G8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWwG+bgEWk0wT/bSuyXxPZ+6YaWz+8PWwlctk6dwUGKw+WQEc3
	q0KHVEsdegytGLNe5D4rUC1fAjemstGZ71bebitBrw/trgwuOlUkIepyDcwL2+wYs8vAG4kLU6m
	x1WnntxE66509LRNOXNYII+UE+On/ZYw=
X-Gm-Gg: AeBDieuYgg46qJHx4EvDzyLl5wYYtymJsHrpdDPsfw8CS5/WI9ToyM+HsFpiAOtBWWO
	/Fkbg1ZusLIc5EfphQ4g9+8sHeDC/ipVSAehqQq8WK6NbCWWNHnLx6S1fH1qpzsn59DAj5Lj5Pq
	V2JX4yJdyH9r3Hu6c2Z1zSGJJjg266wI8o0V7SyDdD1ZVz64ZLQu7FtHQg0WbrigaZn1ZUlkoGs
	0NJvhazfLE/T6/QDL/t6dTPYE/cDUreTxJ2ituvEBUUYhQFRdfwzjiMmB2+EN8ccQ4RkTeY2XFd
	IkaN+PTY2OoHg1o5fqQJn+BbXLMg7XuP3KhXIqzjevpBk80=
X-Received: by 2002:a05:690e:1699:b0:651:bb90:714d with SMTP id
 956f58d0204a3-651bb9071f9mr15120885d50.32.1776270657069; Wed, 15 Apr 2026
 09:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413182427.298513-1-michael.bommarito@gmail.com> <20260415161720.GN772670@horms.kernel.org>
In-Reply-To: <20260415161720.GN772670@horms.kernel.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 15 Apr 2026 12:30:45 -0400
X-Gm-Features: AQROBzBJ7VPEuVDr74gDATAW33m2tupUjmRHD1ATtbA3VSrDaDdMAX-O608I1JE
Message-ID: <CAJJ9bXwQyd-cZ0h_FCNj29GZYpXyCBu444VhLGLZkf1bWYqoKQ@mail.gmail.com>
Subject: Re: [PATCH net] ixgbevf: fix use-after-free in VEPA multicast source pruning
To: Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278841-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,scan_drop_continue_loops.py:url,null_after_free.cocci:url,cancel_work.cocci:url]
X-Rspamd-Queue-Id: C74E1406674
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 12:17=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
> Sashiko flags a number of issues in the same function that
> do not seem related to your patch.
>
> I'd suggest looking over them if you are interested in
> follow-up work in this area.

Sure, I'd be happy to keep going here if you're open to more hardening
patches.

Two Qs for you:

1. Do you want smaller patches for each or bigger method-level patches?

2. Anything on my list below that you would *not* want me touching?
I'll combine with anything I can find from your Sashiko items

    1. line 104
       rule:   semgrep bug-on-in-net-code (CWE-617)
       match:  BUG_ON(!test_bit(__IXGBEVF_SERVICE_SCHED,
&adapter->state))
       where:  ixgbevf_service_event_schedule()
       status: untriaged

    2. lines 1219-1225
       rule:   net-drop-continue-in-loop + scan_drop_continue_loops.py
       match:  VEPA multicast pruning kfree_skb + continue (UAF)
       where:  ixgbevf_clean_rx_irq()
       status: SHIPPED as commit ca62ac02b30d (this patch)

    3. line 2769
       rule:   semgrep signed-int-as-size-param-kmalloc
       match:  q_vector =3D kzalloc(size, GFP_KERNEL)  (signed size)
       status: untriaged

    4. line 3452
       rule:   semgrep signed-int-as-size-param-kmalloc
       match:  tx_ring->tx_buffer_info =3D vmalloc(size)  (signed size)
       status: untriaged

    5. line 3530
       rule:   semgrep signed-int-as-size-param-kmalloc
       match:  rx_ring->rx_buffer_info =3D vmalloc(size)  (signed size)
       status: untriaged

    6. line 4114
       rule:   semgrep narrow-accumulator-overflow
       match:  i +=3D tx_ring->count;
       status: untriaged

    7. line 4189
       rule:   semgrep narrow-accumulator-overflow
       match:  count +=3D TXD_USE_COUNT(skb_frag_size(frag));
       status: untriaged

    8. line 4192
       rule:   semgrep narrow-accumulator-overflow
       match:  count +=3D skb_shinfo(skb)->nr_frags;
       status: untriaged

    9. line 4695
       rule:   coccinelle cancel_work.cocci
       match:  INIT_WORK(&adapter->service_task, ixgbevf_service_task)
               with no matching cancel_work_sync on teardown path
       status: untriaged

   10. line 4752
       rule:   coccinelle null_after_free.cocci
       where:  ixgbevf_probe() err_dma path
       status: untriaged

   11. line 4795
       rule:   coccinelle null_after_free.cocci
       where:  ixgbevf_remove()
       status: untriaged

