Return-Path: <netdev+bounces-277461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEnuEQsg2WkQmggAu9opvQ
	(envelope-from <netdev+bounces-277461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:06:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5EC3DA102
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFB3F30C0568
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A053DC4C3;
	Fri, 10 Apr 2026 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="cs+zJ0r8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64113DA7E5
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835135; cv=pass; b=lC7e8AgIZa5jtwNwYY6G2fmI3cWj6ZTemHaZwyD1HKEiBI4ZhQGWkfFDtLZMFZUIb/kQRzxCU45thNIp9/mxrToRiaK+vbUUw4QaKQnThNq5t63wcss1F+q6nLs48Xm+suN2P3hLylRyadLRPEBA6uH5UdILJY5AEkemT3M8nl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835135; c=relaxed/simple;
	bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bebExFI3ORs/Ofw/HmQymKodmf8Ep7or3NjZq7L8zRvt0ZM0+WtB4fviVzFl+AP2j+6VO6yox0xQLgkwVVA/mM+2i2gYGQX/GqvJ7Rz/SkM0kNhRHQXUoWVaR9b8HxIvWqgN73X1ESz7Vjnq8uCMXECumDJfhv3kbFpdE8VCBV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=cs+zJ0r8; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c1a170a50so2014881c88.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 08:32:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775835131; cv=none;
        d=google.com; s=arc-20240605;
        b=E9VtaE4OoeWUB8h1oXgHda7Zr1CS/JPu0k56OsaBYeyTEWS6iDVUQ6fmL1LbWxoGVJ
         sscEqTnKEkWCwSkJREXZLd+/+jG8PxXSPKu3MNLxBVi1+TnWdSqDPTPyJvFOYwncnsyR
         2j/aazRrljn6Enh1FWHMtZIfW0oCX3oHPQa+ej6+sbnfuJWuATetHPYaogJVTuFBTR0S
         ACHZox6pwZg3wrHGrNASQLkoBA0yH1Ul+4gvfsdHkRR2oCgmq03dVBshmjdVT2tJicr8
         TCk9gZAWDkXp4buN9xTSD6oz65hruguVK/0BVLDEpcr4yEHoEsZCHweA/USkPiQ0I/bt
         PNpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
        fh=ZQWMg/Zd1GXNdJ6FssB+aejBdTAoYGflaQgYST1jFQg=;
        b=T05nJnSToPy2XJS9v0OkhNMDDatptYVqkBcCr1GaoU9ek8KQMnc+xgSsLuYi4QH6wW
         YGPzfna8sD03x0c5Y+QQ23PmtilnPBUVKn1hywBHqruHv3YYVQY4pn6hZ2we51wCYe6n
         4hcVf75P4Rgaja/jMn/lJfqsZzik7XiByNjLoW+o/LE/qdCnUQx9/zzidzzbBFlmLrcz
         A7rgVTNXlCFEa11+Z1JU5UjyxoCDXEiHvp0z/LjnQ+IjBFm6Fc7VjB0JXQS6ZZkOZdhN
         xh6wCbhPc7eoL4Q9ZW+9DqE9R9s9/f/FFntHJDWp9KO01nmMjGjtpNi/UnhCXusmWeJe
         fDKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1775835131; x=1776439931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
        b=cs+zJ0r8E1VxbeERL/6orYDfRzBNN0xV+FBDuuOmam2/EuHZ7scxaUctzZ3REo2LBr
         KdQSu4tLtUeUQ/Am7PGmtjXBLQ/7knpdVClf5erC+tpkhYxe59BfVvuW88STHDIDr49T
         TpKPrBeobAalm+DfnxseCj+mCeyPg4AFXq4Ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775835131; x=1776439931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
        b=DiRwEPTXP6/xdSJLEfXN3wqrijWeieyxetrtxbdIIY92efa9rkxcNOqKx3u0dGxemg
         vCL3XR/xb5WlDRpUZMF9q3Hfhy//mtKaJvenCeOPNhv4LL8CmZr7KBTcBYnqjOVMam3t
         eQ03S1UZUWvjH6HJDjNX3GPZfN/EcGO4kmcX3n9uaSlLcoqqEIyau/0c4BNI3p4WcJOt
         jk4wiTd+sGzeRpC/QWEmwtGAp92RKLTKY/DD4U7D/jvdZBG47aKzJcAG7X1/cOPSeEKM
         TSkuGf4klrhzmmN26vSiqpVgDCJg/KtIL9AuS+KUlJYUfwpndGc2lXpPlTLEw2RqyPnc
         aGhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX20ybfhbK0QYEVdBR1zrpB1FhvwMNIuNWVrfwnZfmOnEZWev9ZMxS7Au/AAYVMiVWFK5mQFnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqzQ3Gu8QiUQF4WuujiE3rzYceSeSV6p3oJRZdt1OkK5lswPnZ
	4RZo26n3NINJgqtxZGInl7/plVlBJBHopdodsbhoKY+T7R61Pt/BldylFEJh4Kt9K7o9Wgao/4d
	cvYL1ZO+rIzcs1YYf5ttWfycc4fdgTkhfrMvi1Sn0Eg==
X-Gm-Gg: AeBDieuiD7x/p32Gd06YXu9EIGtj86/DCtyRt5U6aE+LMR4P5DrFgL+RJtghhEB2Xkg
	RafZSml26yt3PKqU4l3sXSIn7JWH5vfn4WHVj5/4LvYkDj/9JMcjCSJ9bSYi/HrhH+HyVD1xdoJ
	q1H7w1h70yF7pMLP3YaB0oC+kWz0MJvsEd5Us9kv14jinRA1Vtuc46DjafDkbIkMoY+GAizYkam
	Ry93YkbBxdsKY90LPskcw6Xhh/yigT3e6Ubdv6JObd3VxCIRT0H3xjLJBwQEWhIlCoAC212sgah
	T9ny
X-Received: by 2002:a05:7022:6097:b0:128:ccb7:7fa3 with SMTP id
 a92af1059eb24-12c34f069f8mr2159203c88.34.1775835130696; Fri, 10 Apr 2026
 08:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120319.397219631@kernel.org>
In-Reply-To: <20260410120319.397219631@kernel.org>
From: Daniel Palmer <daniel@0x0f.com>
Date: Sat, 11 Apr 2026 00:31:59 +0900
X-Gm-Features: AQROBzAnX-XEClLFV-qWYFUzCuq4P43sNZviESiWFI1yCPXm2VtVZ2QkaUGJoPY
Message-ID: <CAFr9PXk7qK8-2JWrrfgXHoS9JWTRL+WobLjmAesyCE9VLL8ZyQ@mail.gmail.com>
Subject: Re: [patch 27/38] m68k: Select ARCH_HAS_RANDOM_ENTROPY
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[0x0f.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[0x0f.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277461-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[0x0f.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@0x0f.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux-m68k.org,lists.linux-m68k.org,arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,thingy.jp:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0x0f.com:dkim]
X-Rspamd-Queue-Id: 9F5EC3DA102
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi

On Fri, 10 Apr 2026 at 21:39, Thomas Gleixner <tglx@kernel.org> wrote:
>
> The only remaining usage of get_cycles() is to provide
> random_get_entropy().
>
> Switch m68k over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY and
> providing random_get_entropy() in asm/random.h.

I have built and booted this on my Amiga 4000 and it apparently still
works so FWIW:

Tested-by: Daniel Palmer <daniel@thingy.jp>

