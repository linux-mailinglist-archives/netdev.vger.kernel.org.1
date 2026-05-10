Return-Path: <netdev+bounces-286318-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLMeII2oAGqTLQEAu9opvQ
	(envelope-from <netdev+bounces-286318-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:47:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ECF504EB7
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A03AF3008794
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 15:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114B33815EA;
	Sun, 10 May 2026 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Va9YbzH7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D54318EDF
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778428041; cv=pass; b=bW9NXiqSRu75YVTnPCaztdmqOBJSKfowiOh8wg66uhoCYT1QbjV0M7BDGBsgzVRUS7pZnSYzLyNZkHnAyHcDb2bRo9nNhA727T40do32N1pXAe9/DXHMpyBREOBDD5SQ2mAXi9a504NJUWpinJGp8Cd1Rjx9cIWIdtYfZnv/9dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778428041; c=relaxed/simple;
	bh=lhY2lNgi8WlM2WwMpazzz39x0Lx/o1MnElliYXTlzBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i77GY3JoB74HOREQidVXwM1aMmgCERvH6hofj2a4lmzsDoCfZ6RlGStr8v8K7GNdQ0zZvs6NLFPrr/60x2CyCKVE5j/vgAt4oBOHujVatG4+bqicabCrXD4h795cCDgEJ96R7qAWila+R19GflO3hd/61Kl6D6ST5VXyt+GOWck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Va9YbzH7; arc=pass smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-bcc859ac07fso23036366b.2
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 08:47:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778428038; cv=none;
        d=google.com; s=arc-20240605;
        b=Wl9a0mwUvA1TiLazuCpmxWTaREql8aRHVaNA06S4dJP9IUXLB0tYKWhqzi0fhPReoi
         BuDYlbRSI2v0WWTbwq962z8zBHIYyHpWGgU1HYdA0KcAD/CamISAFBNebcclxXq+owV1
         pL+wL1ECjfH4UdDzmgC0d7jJigMvF2a07jz6FCEBY0flZoXHzxaH5RcJFtO06/TwWKNU
         yu+T0nYNcsnmbiW9wfcCrGqDSPXSAfqVSenVrZdmJr+3djg15cGkwhxUtx9q3qYI8syI
         sYZIXSz+n9hD8HnetG5DNLcT31ibqd3hvLFpe2/zXWcP+2hwGML5awR4FnwS6ceFyic+
         SS/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GhEj/mUqB2u9/ae3N3PSRwZhRlcMwktJBN18e/nk1wg=;
        fh=zbcMc/hIVq95uc44GwYhp+GhKAoe87/DCbpCx6FuO1o=;
        b=iVWmlnlpLF5yHwQRd+4DlnMZNqld4KMnhWzJkgJmWUSN8nHgkX6b30NIuvF3pXKiNr
         yfCWviazFy1v9l5I1WBXq3ryAPqEg4fpfIuUmlp+stC7PDSiX3+xvaHaTxCS0Oprh+Co
         aOJ29tX6ScaWvvgz9vj1ymf2IXu3qw4Af+B1Ti6fBX6QyIKlEUeGVUHNOCeX0TkIhpYS
         yNDgM5ZLzlRnVA6B6iVCfmW0O3ArtG0qjcDYqNqYnORurMNi2ZZD4FuIPDzKdujEDshx
         K4uDWzG/0LP02dKNIO9KuW0aDPo6PgedZLLc7dg41W0ykFOJFCfNKo2PvF4JLWH3n44H
         TruQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778428038; x=1779032838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhEj/mUqB2u9/ae3N3PSRwZhRlcMwktJBN18e/nk1wg=;
        b=Va9YbzH74nuyTWP5ekDDPh0vYbP4jZfP0W7tad47K4DJP1SJLL8uGMwAB+c6OiPX0b
         Kbh2jy1pYMwY9WDOJFFvUDHMjiIG8flJw1bGd7IpjKjOlLO86wuMW/b8qbLdd+Fgn3cR
         gD3ETpUgeW4TF9WBqffJ0NxCXusIyhIS2scjgh+Myt6MBmG9L/SA4Eh6s7/5stTQ7EgP
         rGgysh+AwYad/Ppx+AShPCV4v7XNi2eVhY800QJxloSnYJUFS4JNzaBZ1Uv6/X4AeNlO
         /69ZqvzNtX06y5+KQtT09UAMeKGQzTuubVlnXFaPtuOynWI5hodblt1qpnhA7gvPhH75
         Qq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778428038; x=1779032838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GhEj/mUqB2u9/ae3N3PSRwZhRlcMwktJBN18e/nk1wg=;
        b=GpMpQaSyIX7o4lx2f29J9X1owHmHI4XCsMUD5T/r/aflQs63kugDGyYJdWC/Amrfq/
         Zf5qXfUwMlEb7yvcxFJILc+HSl5Kl5cQs7uw5QPCep7pn50moeSnRRZv1rJnzU2Jg4x1
         6W9OTNV5s5d45jJzpeFXCLtRlxgtFlMnDOMGK3XqMGQr+GIxsw7CriRBJgKJDmvuWajh
         acof4hAVXjOmIgYnkIkXKM3aLhGqE9DQ67dS9pRGC7ZDR+5MZW+FtSDiBtmRU66Yay3/
         Ry4ySA2Q0lipJAbkNJfhBiBMKNfpEde2/RvhJImXQJEziOK0uB8KJwUzFRMExiJOZJ6L
         p8HQ==
X-Forwarded-Encrypted: i=1; AFNElJ9x5T8hmKyjGsyZnD2PFErGP1JhGbYpnojRcofxXPpoy17v8l2Y1+OsBF8zdoISqVYc9ydtB4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyYaVT+rgtzKp6+Qt3Jy5iG1rlADpsM+IWt5WOIPuA+vtfIZhI
	yUbUXBq5qbKYDPbwL/Z1F0PpG/tcG7nR/U+3y42sATC9mtncf+ZKKJhSweiIM/v7yWMPtRc2l+q
	u9MOkxA4LEFtIGKT9PeOlEIBtk3iv+pA=
X-Gm-Gg: Acq92OFMfLSTO7B0btP7keF1d3SA9KoWZw9p4KDDco9YlLEJIZvPDZIgnh2PjzCj561
	hsawgUsRF9ZKpTdMmBk2ytWP1V/vM5GEYcvExSJTysDp+Xp70SFSgN/Q0NH6RVGbEJ15kkWs0TF
	jARGe7HUKhwJDmN6EIAU7ayJrK4214C4pF+CmjrEdniHng21E4X6nrGOA8s3iuMKSPdmihv2b8M
	qwqU6kGKy3UrbFJ3w/DbNmULlgWyVW6e/ThzvXqBaJ8jLX27HxbWdED2ngbANdp/nr8vHP+/TBE
	EDjhzQESHaexIur34is16sfIJanOOW8hXGLQwvaTq6cW
X-Received: by 2002:a17:906:2898:b0:bcd:3d3f:175f with SMTP id
 a640c23a62f3a-bcd3d3f1dd9mr58009966b.7.1778428038260; Sun, 10 May 2026
 08:47:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505192549.74382-1-lucasp.linux@gmail.com> <202605101615.XGX7gOua-lkp@intel.com>
In-Reply-To: <202605101615.XGX7gOua-lkp@intel.com>
From: Lucas <lucasp.linux@gmail.com>
Date: Sun, 10 May 2026 17:47:04 +0200
X-Gm-Features: AVHnY4I5BJ3WUNxvWShvJiYRdsMV2EajZNf_laz8BJg49nA64GiTUogqPkpeJLg
Message-ID: <CAKYXYMRRoMJk2Ztr7R5r-yTmpY-aXcMmJ7FgMPYOF+ozQg7Uwg@mail.gmail.com>
Subject: Re: [PATCH] llc: fix coding style and memory barrier documentation
To: kernel test robot <lkp@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D4ECF504EB7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-286318-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucasplinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url,git-scm.com:url]
X-Rspamd-Action: no action

Hi everyone,

I would like to withdraw this patch from further consideration.

Due to personal reasons, I need to step away and focus my attention
elsewhere for the time being. I won't be able to follow up on any
reviews or necessary changes at this stage.
I am very sorry for any inconvenience this may cause to the
maintainers and the community.

Best regards,
Lucas

On Sun, May 10, 2026 at 11:01=E2=80=AFAM kernel test robot <lkp@intel.com> =
wrote:
>
> Hi Lucas,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net-next/main]
> [also build test ERROR on net/main linus/master horms-ipvs/master v7.1-rc=
2 next-20260508]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Lucas-Poupeau/llc-=
fix-coding-style-and-memory-barrier-documentation/20260510-102311
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20260505192549.74382-1-lucasp.li=
nux%40gmail.com
> patch subject: [PATCH] llc: fix coding style and memory barrier documenta=
tion
> config: riscv-randconfig-002-20260510 (https://download.01.org/0day-ci/ar=
chive/20260510/202605101615.XGX7gOua-lkp@intel.com/config)
> compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5=
bac06718f502014fade905512f1d26d578a18f3)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20260510/202605101615.XGX7gOua-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202605101615.XGX7gOua-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> net/llc/llc_input.c:181:3: error: call to undeclared function 'dprintk=
'; ISO C99 and later do not support implicit function declarations [-Wimpli=
cit-function-declaration]
>      181 |                 dprintk("%s: PACKET_OTHERHOST\n", __func__);
>          |                 ^
>    net/llc/llc_input.c:194:3: error: call to undeclared function 'dprintk=
'; ISO C99 and later do not support implicit function declarations [-Wimpli=
cit-function-declaration]
>      194 |                 dprintk("%s: llc_sap_find(%02X) failed!\n", __=
func__,
>          |                 ^
>    2 errors generated.
>
>
> vim +/dprintk +181 net/llc/llc_input.c
>
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  151
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  152  /**
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  153   *     llc_rcv -=
 802.2 entry point from net lower layers
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  154   *     @skb: rec=
eived pdu
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  155   *     @dev: dev=
ice that receive pdu
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  156   *     @pt: pack=
et type
> 74c950c966c180 Andrew Lunn              2020-07-13  157   *     @orig_dev=
: the original receive net device
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  158   *
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  159   *     When the =
system receives a 802.2 frame this function is called. It
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  160   *     checks SA=
P and connection of received pdu and passes frame to
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  161   *     llc_{stat=
ion,sap,conn}_rcv for sending to proper state machine. If
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  162   *     the frame=
 is related to a busy connection (a connection is sending
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  163   *     data now)=
, it queues this frame in the connection's backlog.
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  164   */
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  165  int llc_rcv(stru=
ct sk_buff *skb, struct net_device *dev,
> f2ccd8fa06c8e3 David S. Miller          2005-08-09  166             struc=
t packet_type *pt, struct net_device *orig_dev)
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  167  {
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  168         struct ll=
c_sap *sap;
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  169         struct ll=
c_pdu_sn *pdu;
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  170         int dest;
> 846d7f9be89210 Lucas Poupeau            2026-05-05  171         int (*rcv=
)(struct sk_buff *skb, struct net_device *dev,
> 846d7f9be89210 Lucas Poupeau            2026-05-05  172                  =
  struct packet_type *pt, struct net_device *orig_dev);
> aadf31de16a7b2 Ben Hutchings            2012-08-13  173         void (*st=
a_handler)(struct sk_buff *skb);
> aadf31de16a7b2 Ben Hutchings            2012-08-13  174         void (*sa=
p_handler)(struct llc_sap *sap, struct sk_buff *skb);
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  175
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  176         /*
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  177          * When t=
he interface is in promisc. mode, drop all the crap that it
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  178          * receiv=
es, do not try to analyse it.
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  179          */
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  180         if (unlik=
ely(skb->pkt_type =3D=3D PACKET_OTHERHOST)) {
> 0dc47877a3de00 Harvey Harrison          2008-03-05 @181                 d=
printk("%s: PACKET_OTHERHOST\n", __func__);
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  182                 g=
oto drop;
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  183         }
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  184         skb =3D s=
kb_share_check(skb, GFP_ATOMIC);
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  185         if (unlik=
ely(!skb))
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  186                 g=
oto out;
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  187         if (unlik=
ely(!llc_fixup_skb(skb)))
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  188                 g=
oto drop;
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  189         pdu =3D l=
lc_pdu_sn_hdr(skb);
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  190         if (unlik=
ely(!pdu->dsap)) /* NULL DSAP, refer to station */
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  191                go=
to handle_station;
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  192         sap =3D l=
lc_sap_find(pdu->dsap);
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  193         if (unlik=
ely(!sap)) {/* unknown SAP */
> 0dc47877a3de00 Harvey Harrison          2008-03-05  194                 d=
printk("%s: llc_sap_find(%02X) failed!\n", __func__,
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  195                  =
       pdu->dsap);
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  196                 g=
oto drop;
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  197         }
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  198         /*
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  199          * First =
the upper layer protocols that don't need the full
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  200          * LLC fu=
nctionality
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  201          */
> 23dbe7912dad6b Stephen Hemminger        2006-05-25  202         rcv =3D r=
cu_dereference(sap->rcv_func);
> 696ea472e19c6d Changli Gao              2011-02-22  203         dest =3D =
llc_pdu_type(skb);
> 6aa7de059173a9 Mark Rutland             2017-10-23  204         sap_handl=
er =3D dest ? READ_ONCE(llc_type_handlers[dest - 1]) : NULL;
> aadf31de16a7b2 Ben Hutchings            2012-08-13  205         if (unlik=
ely(!sap_handler)) {
> 696ea472e19c6d Changli Gao              2011-02-22  206                 i=
f (rcv)
> 696ea472e19c6d Changli Gao              2011-02-22  207                  =
       rcv(skb, dev, pt, orig_dev);
> 696ea472e19c6d Changli Gao              2011-02-22  208                 e=
lse
> 696ea472e19c6d Changli Gao              2011-02-22  209                  =
       kfree_skb(skb);
> 696ea472e19c6d Changli Gao              2011-02-22  210         } else {
> 23dbe7912dad6b Stephen Hemminger        2006-05-25  211                 i=
f (rcv) {
> 8f182b494f8779 Stephen Hemminger        2006-05-25  212                  =
       struct sk_buff *cskb =3D skb_clone(skb, GFP_ATOMIC);
> 846d7f9be89210 Lucas Poupeau            2026-05-05  213
> 8f182b494f8779 Stephen Hemminger        2006-05-25  214                  =
       if (cskb)
> 8f182b494f8779 Stephen Hemminger        2006-05-25  215                  =
               rcv(cskb, dev, pt, orig_dev);
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  216                 }
> aadf31de16a7b2 Ben Hutchings            2012-08-13  217                 s=
ap_handler(sap, skb);
> 696ea472e19c6d Changli Gao              2011-02-22  218         }
> 6e2144b76840be Arnaldo Carvalho de Melo 2005-09-22  219         llc_sap_p=
ut(sap);
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  220  out:
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  221         return 0;
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  222  drop:
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  223         kfree_skb=
(skb);
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  224         goto out;
> 846d7f9be89210 Lucas Poupeau            2026-05-05  225
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  226  handle_station:
> 6aa7de059173a9 Mark Rutland             2017-10-23  227         sta_handl=
er =3D READ_ONCE(llc_station_handler);
> aadf31de16a7b2 Ben Hutchings            2012-08-13  228         if (!sta_=
handler)
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  229                 g=
oto drop;
> aadf31de16a7b2 Ben Hutchings            2012-08-13  230         sta_handl=
er(skb);
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  231         goto out;
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  232  }
> ^1da177e4c3f41 Linus Torvalds           2005-04-16  233
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

