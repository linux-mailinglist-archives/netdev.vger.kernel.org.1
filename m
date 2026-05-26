Return-Path: <netdev+bounces-291974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I2YGHUrFmqdigcAu9opvQ
	(envelope-from <netdev+bounces-291974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:23:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2625DD82E
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 594223050F71
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 23:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64E13CB2C7;
	Tue, 26 May 2026 23:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoF8Uarq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EA43BB661
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 23:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779837712; cv=pass; b=FchI2/O/Ho2CLnK8j9jjV29A26GCvYaSsCGaucvV+x1qJtiEdN5NCzxMo5N2kSj1Kzy5cTR9Y37SMA8ZQw+Hj3ch/b/waFSbVvfQxi9NwW9VfRkUaHX9DtZ0ipKs7O8XydU/kTUW7WKzuAtS0fkezG+bYTUdCrPsnqrzt4Ntc6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779837712; c=relaxed/simple;
	bh=u5AZ6lDvJHN6hkOMWJlEHdIYy+BPs1w8b0bOdZZRyJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8P1loUVUomiiqG9jxUxwmMUebwmX8mlQo+8Wpdy0jft0r43JcylwcnNbckyPyjoJFck8OCFktOuizbYdXtThk41HbgyFc4aVq2TynN5Q1N8nv3tM9JIwgnVvn2FjUsLWDOX4WWGLoZnoITs+NEORCwa+iygIRfRq/nriaBScMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoF8Uarq; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-43bf6230cffso1231950fac.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 16:21:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779837710; cv=none;
        d=google.com; s=arc-20240605;
        b=bxeHUtN/4y6ENY9HlZ9co6fhXhhM2f2bvWm0KOKHV2ywvjr5JuQIfsC8FvedcCsDAP
         LCyvZLVS/qTjyjANg4n35in17v30Xq9lJxFpquuz0M1MX/Br/4JNsjGoazSKjdpMubFk
         pkY58nz5XtgERMl7pLXJEPWmLalq92npcITp7i94MFv1wpw1M2E5PZn/vW8qPb1ZRn7m
         yu7R0V97j5ExXU6XbePdjjEyKxU1URXR5hoRwqM5PJEH7kTcbe0emJXS3dIclXtO46YM
         SfmxAR0LyB+E0fRJKMpBOJqcPQ00G5A2owxeyuVRr4cdumTF+nkbNeLvdmUO1vDFV/aW
         YqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HujuVBuKdWWEfICM8n6u8a8X3rF3iweG2fpAlmRVj68=;
        fh=XLym8Egy2CGh+uoCatzHlxuZSbhF7HWk8+vDF0CH5r8=;
        b=L2xlpOb2l1XjhgHhzduXC52Hf9kv4fb8/axdJF8BqWoiaB/IzRy12eMQNY76orB9Zc
         NZhmQDWbHnOQ9UBGplg2VcgbuFf7tpMPyKbIYHmhb7eB17cpOakijgVjokFd4rufLuIV
         J5HARzJbXv4Iqq+mjZVqyleS6kwz01CsqXT5xi/3hJ2IqxrnB38J2UwG1KRsna6STLTa
         ExcfYiuPySHnVjbgAH8RTD2t3LHdDhpEcqVCjMSpuI2vnAjO+Bkm24LlgPoGDjF4nc5P
         zFdQ6TJ3FG1TQtygNgk4b30VoAxHUUtZfLLg8wJGWSsqHQjKCMUznj70c6MiXjgO+Crq
         WEuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779837710; x=1780442510; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HujuVBuKdWWEfICM8n6u8a8X3rF3iweG2fpAlmRVj68=;
        b=ZoF8Uarq/TldyaYIzCoGeNZ4a27AC5yVtMW2qA6Tq9NzzWaOekALVchygvW560Li57
         VEI7YHopZ1NPwR5c4jDdIWBBGBy5szAPuY2g8Sebgwsu6Srwp+6KIZMbFR26UksalAqR
         /Ar4cOnt3DJDonqFEM5D8vyKYvVSvGsfoInObizwy3IygcHiBMTU9RUkLaauWzZGhZN4
         sJ8H7IfBEpqPZyeaRUURQi+O8KCm0ESpIrzqou+SbZh7vqjIF77HWQzXdCYKNcE2p5ja
         XdTYZPCEWLbvOKLLf6BiiK24XjBh+QgJlYovwsMDMFUdvrOkh/ahAXlltSyXVJPE7efq
         phmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779837710; x=1780442510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HujuVBuKdWWEfICM8n6u8a8X3rF3iweG2fpAlmRVj68=;
        b=dYNYuZiMJpE4Yqgr6TOcuXmvrXESevC+X1WMGJH3v3YHQBSaQ8x3yg3n+kKqYWpq/U
         VrPpgN1QLBUfctmdCgAXjKV9XVi59gcpCLBFsGGLyxXG1Ju1rFugBMxtKGc0uzxvoiop
         N9T9dMkiPOr901+jd6FNLRtfOnOl7e8e+0ntM62D9bnO6EeKg5yMncNfTcjEnR/d/1s7
         V0xzcCz3jp61w9AVhGQ7ERGFqnQTiJwn0aZnOXbh0Xr3CvL/n1iHMJrIZAOBA6B7IUcM
         OBe6o7XhdV6fBmlLrKF/eYi1uQLMgoZXPeNV9LExr9if/1hDfBM4z2JYZIEjcL+RIipz
         D2Eg==
X-Forwarded-Encrypted: i=1; AFNElJ/y51C+MvzTvn+hhB1hUhCIY9rTvKHX/dS9z2EfcRr6A0hlLUuOs2oDrq/ff/fPrG00Zi9+Ku0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD6+fOqO/vQ89YhGBq3Ya66JjWRZjV2BSzHvnCEp0rGIR2dtd/
	0uuUmUiP9VFXrqlWUtq9Nep10UAuN2/OL9u+qqxaPRelVMW9axeswX9llcHEXhmAbe49xDD1Cxh
	7GbK93bemznuFkHUrbjvn58b1exxQGLc=
X-Gm-Gg: Acq92OELQqMq6SGG3HNgf5ViZCrev7UC6JfjOelrGfV2PKohSbGH+9UcA8HVkLsO/da
	cAvNbytpHvKKonbrS/p6gIEPT92SscMJjhqyCuPZuMHLgdHFmerg5SfynisMFVSh5O4Fx3Yne4P
	7vnfD3tCb2ggZoFbWDR2smQf8RsOvUgCU+67JSRNv4sgmQH5l8UDyuDTG8XxXBpKK+smka+EFtH
	7rH0Acqol3cK5h0exQ7RVq9j4TflwyYZ/T/xgUcZu3FDpHoClDJj+ZS9AxmI/oCQUXLbD75qlNU
	mWScSZIYF1t94QJV2B61iOrByCE=
X-Received: by 2002:a4a:e903:0:b0:694:9e2f:cfac with SMTP id
 006d021491bc7-69d7fcb51b6mr8951696eaf.9.1779837709977; Tue, 26 May 2026
 16:21:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525201116.407338-2-kacper.kokot.44@gmail.com> <202605261807.YY0PWuhX-lkp@intel.com>
In-Reply-To: <202605261807.YY0PWuhX-lkp@intel.com>
From: Kacper Kokot <kacper.kokot.44@gmail.com>
Date: Wed, 27 May 2026 00:21:38 +0100
X-Gm-Features: AVHnY4IeURuAw-7kug8a-6xqNpmP-8aoIQEcxEzrITr5eMpT52Lzw3oZg7lhaRo
Message-ID: <CAG-Fur7edB8_4iLnP4QWh+K96bGFBgYyfdoy8H7zvqa8NYdyow@mail.gmail.com>
Subject: Re: [PATCH] netfilter: TCPMSS: fix dropped packets when MSS option is unaligned
To: kernel test robot <lkp@intel.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291974-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kacperkokot44@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0F2625DD82E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> AFAICS, these issues are not present in real environments as MSS option
> is placed at the beginning of the options block making it aligned by
> default usually.

I agree, I haven't observed it in any real environment and wouldn't expect to.
I found it by reading the code and had to craft a SYN to reproduce. That said
the spec permits unaligned options and the kernel shouldn't silently drop legal
packets just because nobody sends them today. I can note in the v2 commit
message that this is a theoretical fix.

> > I wonder, if we are touching this code, we could use the opportunity
> > to make it use get_unaligned_be16() instead.
>
> gcc and clang convert x[0] << 8 | x[1] (etc) to the appropriate single
> instruction (and maybe byteswap) on cpu that support misaligned accesses.
> So there is little to gain from doing it any other way.

Happy to go with whichever you prefer for v2.

> and, of course, the code works fine because 0x1 != 0 is 1.

Ha - accidentally correct. I'll add the parens in v2 tomorrow.

Also the reproducer I sent with v1 was clunky. Here's a better
one with some results below:

  #!/usr/bin/env python3
  import argparse
  from scapy.all import *

  parser = argparse.ArgumentParser()
  parser.add_argument("target_ip")
  parser.add_argument("target_port", type=int)
  args = parser.parse_args()

  def gen_mss_syn_options(nops=0):
      return nops * [("NOP", None)] + [("MSS", 1460)]

  def syn_check(opts):
      sport = RandShort()
      ip = IP(dst=args.target_ip)
      syn = TCP(sport=sport, dport=args.target_port, flags="S",
seq=1000, options=opts)
      synack = sr1(ip/syn, timeout=1, verbose=False)
      send(ip/TCP(sport=sport, dport=args.target_port, flags="R",
seq=syn.seq+1),
           verbose=False)
      return not not (synack and synack.haslayer(TCP) and
synack[TCP].flags == 0x12)

  for i in range(7):
      n = 5
      ok = sum(syn_check(gen_mss_syn_options(i)) for _ in range(n))
      print(f"{i} nops + mss, {ok}/{n} probes responded")

Before:

  0 nops + mss, 5/5 probes responded
  1 nops + mss, 0/5 probes responded
  2 nops + mss, 5/5 probes responded
  3 nops + mss, 0/5 probes responded
  4 nops + mss, 5/5 probes responded
  5 nops + mss, 0/5 probes responded
  6 nops + mss, 5/5 probes responded

After:

  0 nops + mss, 5/5 probes responded
  1 nops + mss, 5/5 probes responded
  2 nops + mss, 5/5 probes responded
  3 nops + mss, 5/5 probes responded
  4 nops + mss, 5/5 probes responded
  5 nops + mss, 5/5 probes responded
  6 nops + mss, 5/5 probes responded

