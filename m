Return-Path: <netdev+bounces-284228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCaPNceG+Wmx9QIAu9opvQ
	(envelope-from <netdev+bounces-284228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 07:57:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB774C7084
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 07:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6651C3008C93
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 05:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAEB3C1981;
	Tue,  5 May 2026 05:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlBFVv9B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E859D3BE64C
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 05:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960564; cv=pass; b=q7S18UdBWXgTXm1eeOc8Q8RhecyfhgtRThJUS6G/unOkuBAfPa83oNSxsgWmoBsCZVgI5MnsGUcJV2GEGrbTQc1WOpJlHTwRJO4iWLLg/UWf05E/b0g1/NZBzlEJZiSv+jihuvYFJQhS6mMOT3qXMVOo/DKzI1PTyJgwkL7uf/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960564; c=relaxed/simple;
	bh=9mlovRsEHAoxeI23qyyG5fbABwikFIPVIBRrF6sRJR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyNlo0Ql+Y8995OaIX1FPpw/IbiI+OGfOh3ss0rEbo36Qkw0pGTx/Qqs8xQkVFXKL92xwJJecliCpB8j4PQu5mm6hXdsG9LUqn63SjrlgDpRD0k5L3oLRJo7vX2UqKdHdQypu3LFlEnwP51gOeZ6JmcRUKFTE11Z3CAXFaH3QJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlBFVv9B; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d73422431so4466748f8f.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 22:56:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777960561; cv=none;
        d=google.com; s=arc-20240605;
        b=d51v+MB4jahXAQHqrfxhZCmgrYjHoFyUEg/wxMke01HMjdW1aInZ8EdAUg/NmoXaua
         CUQNWsQW6t+AtsbYGcBuZstKyecShIN1avCjnBRYhFZUF9pOE6Y6OZ2Lqlz4DixYBk0P
         1h2UvIT9ayDx3RUYZ/LWAq++YER+GnO6jjNnMqha1jXtYefYFjfLFV3C9MzgzDUxgIft
         afSGxaT7c4qinl0FxoVYgvsqlr24Wu/GqIIV3asbKSnDVpDk0arD1oxdSczKfcSWv4Q+
         tAjf597F8xuEo5IMHxJKDp5qoVpmPZ31JeBWXuWOeT0LkmQAIHHsHfMUTggdU4Qt5fPm
         +jzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JiffewN6wp4HO0UKxt2HUBfPX0gz1ne+Fe/6CQ+sGQU=;
        fh=67sgK3ZueNPPR4HpPQ1etFBa/RBNn4ULxlDj+HRYZuE=;
        b=iUz/J2pIgWNNAndQYhtBLZh2iC/WEn0Jz4dr4U1DYziN7LSvVOo9qQPm6cqvDNtmpq
         /wvYON3SZTThnOcpfE92M9hHvtyk7zuyz4mIk/mXKwyZMBSrAayc0Clcy8NlgEz9sFjK
         7+eBGoaR28FEN0UgUsirwmLl1+zC1wdntox1j6u3qzTYEanidHPuoquohUSx+Za79BPb
         Csia4aRjmi0BP4x3OPrq3h0rtXWubkqwv0M+LvRR2hCCsA1rPTlg4i2Anoh634upJ2lK
         32PEIHABB0ANi43YmfreJRM1hLgKAjLuFKI3gME/Uswc9KHjOfVdSC2Fg/PJ79ZmvXWt
         O0fA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777960561; x=1778565361; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JiffewN6wp4HO0UKxt2HUBfPX0gz1ne+Fe/6CQ+sGQU=;
        b=PlBFVv9BkkM6J3EGQxcwhf9ntjCmueIQBQuUGLvByK4wvf70DGv2LEj7hXRdq2nKqg
         jkKwzuTAidFM9BXyq7ieuefwuQ50jmcHpnCM9wtaatY0uIP3cVMACNWlbmn7WmHWb4Ut
         YTvM0/uZ+dL4QS0y1eypmUP8RnynA2FHGAe5cd+Z5Jesqn77riLFzx75tQLTbqEVWRcD
         QG+3fooaVjujkhezTKQZPla/jTJE5JhLdxf1DVz6MRLNbJJjjLaarOVYJ3fpNoryYa9B
         +pu7A1t9Y3QeqDHBTIUEu8JEftMUIeejJCRGArh/j9gRhghpR8Aol5tdarvy+KEgPAyU
         9OwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777960561; x=1778565361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiffewN6wp4HO0UKxt2HUBfPX0gz1ne+Fe/6CQ+sGQU=;
        b=F8RSgWhoLg2dFHJNX1TKkZy4aOj5W4LjM9peHZ6/jz66FvJz7QaV7lONswtbwSgTbP
         yDXrt3TPu1TBlzzwm/W4zlGRMei8Kq+bQQm0BN6xrvB7pjSQvr9bv5pDkkRuLgkYzO4G
         rojs7OX0WUTNEvxBjZuqp2ZupJWtaVdCsUyOimkXDfvrP5KGiP2u217ow1DORUM7QfMP
         wObQLU3GDoN0F2aGBdFFP5rYG2ZwnwVvl65ERlIl6GlyIl/lVGfSI8b7fPeIwHXZViOx
         Rd5kwn9Gv5IaaOvtpWaszCu2e3N+zOVzEvg9j9E3w7rUXzFECYuOoQ0nNGf8D50jn++G
         UTyg==
X-Forwarded-Encrypted: i=1; AFNElJ+CY6UU7m40idi3V0+Kidt6HtKWZtygyNe81GHDepDeNGEG+Dno0VLzb8yre1dKqVYKV+KSHHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLh69y6Z461589JEGxCHiMx6n/rzTZA2bGbI9+LdO5JuusynX0
	94BQDooipUB82wmAA5N018WZw58CQn3ablsysZb9ab5LZhq24dOpxptzSUfuNLp76gDbe24uAdv
	Ay0ETK2/4Mr7ITRKerZhapc+lIEd98c0=
X-Gm-Gg: AeBDieu629eqFtb5r5KguD0/mu2DlniSiB0Ep6mm0a/R9eyxiOKRIWXvuYabS1AaaWU
	s7lWbqY14/9tPIyKGE/6yfi7XaMfi8AAUs+SBC4QJJn/rCWeNU6ulPKD8tEmCEdmeM6RPFZG0nZ
	ugpkiqAjUroxYK9VJ/pdQaAeub4zstHDbmWHEnJwDWq8mkGf2FsummjnXEV6u4OleMYHudbrQ3C
	KepT3kDIA78g2OeAlHVzcZKlE80a+FqYHTfCkIy8sBo+RHVkwKG+fuQTGU+4jReVPU59NWGWYvp
	yYiMy4Dx33cq/6fwG7Z9/F0Ko+om
X-Received: by 2002:a5d:5f90:0:b0:43e:aefa:db84 with SMTP id
 ffacd0b85a97d-44bb63f55c0mr21257027f8f.34.1777960561129; Mon, 04 May 2026
 22:56:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502150918.4171847-1-maoyi.xie@ntu.edu.sg> <willemdebruijn.kernel.3269daabfa48e@gmail.com>
In-Reply-To: <willemdebruijn.kernel.3269daabfa48e@gmail.com>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Tue, 5 May 2026 13:55:47 +0800
X-Gm-Features: AVHnY4Ilot4dTwSCSgdn7UVyYB0tCp9-Q17EkcOWWdYDAEvWqeexqcYYHRFeKQ8
Message-ID: <CAHPEe=FF7SKocBUUTGULg1RzW5Oq1o71POuxHReJVxM7ifMy6Q@mail.gmail.com>
Subject: Re: [PATCH net v6] ipv6: flowlabel: enforce per-netns limit for
 unprivileged callers
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, dsahern@kernel.org, kuznet@ms2.inr.ac.ru, 
	willemb@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: DAB774C7084
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284228-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,maoyixie.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Thanks for the review.

I will take the prep patch. The series becomes 2 patches.

  1/2 ipv6: flowlabel: take ip6_fl_lock across mem_check and
      fl_intern, convert fl_size to int
  2/2 ipv6: flowlabel: enforce per-netns limit for unprivileged
      callers (this v6, rebased on 1/2)

For 1/2 I plan to:

 - Move spin_lock_bh(&ip6_fl_lock) and the matching unlock from
   fl_intern() into its only caller ipv6_flowlabel_get(), so the
   mem_check() call runs under the same lock.
 - Convert fl_size from atomic_t to int. The remaining readers
   are ip6_flowlabel_seq_show() and ip6_flowlabel_proc_init().
   Both already run under ip6_fl_lock or read only at init.
 - The atomic_inc and atomic_dec on fl_size in fl_intern,
   ip6_fl_gc and ip6_fl_purge become plain ++ and --. All three
   sites already run under ip6_fl_lock.

For 2/2 I will also:

 - Move fl_free() in ip6_fl_gc() back below the fl_size and
   flowlabel_count decrements. You noted only the ip6_fl_purge()
   reorder was unnecessary. With 1/2 in place, both decrements
   become plain --, so the concern goes away.
 - Fix the spaces around the / operator that checkpatch flagged.

I will send v7 shortly.

Maoyi
Nanyang Technological University
https://maoyixie.com/

