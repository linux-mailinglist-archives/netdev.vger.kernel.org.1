Return-Path: <netdev+bounces-40057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A0E7C594C
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 18:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DF201C20DDF
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 16:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3061A59F;
	Wed, 11 Oct 2023 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tzLt1o8z"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BA33F4BF
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:37:50 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E61B8
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 09:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wVKlx4oGR6ucV6BWnXAYmZumVpM23lR3N4LXS8cO5kk=;
	t=1697042269; x=1698251869; b=tzLt1o8z7zTXGHrLpkumnv+UyKqmiFtNbEHQK8jq8AON5J0
	JHG9pR4OmC5nt9blS1fqlnV+8CUI6moldyHMmqxCfljRdcQ5wKSXSaoJVAme91wiCOxF58Fm2Vp+4
	iqtLjpeF37H3SajZTEcsf5f0FDfhwf7BTnE+5C33iBv7QceM+kkInFbOovPDRMKGYbQEkDMuEdhQH
	aATlhbMENfGWESZtJkys8ccGMw9khWJNnh/obrrW3ZNtAav4snhCGBLn62olIN+KpeYT9aAnK1gdz
	xt7wnHjkutverfTWb1vffWUZ652F+EjQkEb08vYtgoaVXMFiTpf/4AY7DTdxJ7Pw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qqcDR-00000001zd0-30Ox;
	Wed, 11 Oct 2023 18:37:45 +0200
Message-ID: <607ac04334ce4384f2a5a0f2d5a9f58a848ca7fc.camel@sipsolutions.net>
Subject: Re: [RFC] netlink: add variable-length / auto integers
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
 nicolas.dichtel@6wind.com, fw@strlen.de, pablo@netfilter.org,
 mkubecek@suse.cz,  aleksander.lobakin@intel.com
Date: Wed, 11 Oct 2023 18:37:44 +0200
In-Reply-To: <20231011093410.6c330161@kernel.org>
References: <20231011003313.105315-1-kuba@kernel.org>
	 <ZSanRz7kV1rduMBE@nanopsycho> <20231011091624.4057e456@kernel.org>
	 <1335ccffdaaa5a553717e42a855bba1a6f36dc9b.camel@sipsolutions.net>
	 <20231011093410.6c330161@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-10-11 at 09:34 -0700, Jakub Kicinski wrote:
>=20
> > Now I'm wondering if we should keep ourselves some option of going to
> > even bigger values (128 bits) in some potential future, but I guess
> > that's not really natively supported anywhere in the same way 64-bit is
> > supposed on 32-bit.

s/supposed/supported/, sorry.

> I was wondering the same. And in fact that's what kept me from posting
> this patch for like a year. Initially I was envisioning a Python-style
> bigint, then at least a 128b int, then I gave up.
>=20
> The problem is I have no idea how to handle large types in C.
> Would nla_get_uint() then return uint128_t?  YNL also needs to turn the
> value into the max width type and put it in a "parsed response struct".
> Presumably that'd also have to render all uints as uint128_t..
>=20
> If we can't make the consumers reliably handle 128b there's no point=20
> in pretending that more than 64b can be carried.=20
> I'm not even sure if all 32b arches support u128.

Oh, right, I hadn't even thought about that you need to use the max
width type for return values and arguments.

> Given that we have 0 uses of 128b integers in netlink today, I figured
> we're better off crossing that bridge when we get there..

Agreed. It probably means new types at the time, but that might well be
far off anyway.

johannes

