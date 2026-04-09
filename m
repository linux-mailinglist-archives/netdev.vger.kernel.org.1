Return-Path: <netdev+bounces-276757-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJPKKoTy1mlpKAgAu9opvQ
	(envelope-from <netdev+bounces-276757-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 02:27:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4D93C4FCD
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 02:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54760302D94D
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 00:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54DF25F7B9;
	Thu,  9 Apr 2026 00:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2+aEM8S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC4B11CBA;
	Thu,  9 Apr 2026 00:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775694463; cv=none; b=i552YKDUxIKiTqtMHvPGc4aIvA2PDqCGA6l6fMF7+OAcIRmTaSwTickeSpr18nyRYQj5XkqTmcTVk/3mygqL4zpKjeSEyVkb/JxI54j5XdvmJFNb4AgfHOnMHGjZddLEZBf58BSD5sqFqZF29nsMbTmo+xIDJXExmw2oiaSA4uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775694463; c=relaxed/simple;
	bh=OaWiRFhoHwXD0uAK9BEwKIduuJLM7WDD0Sz53F2Z5Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akz3NGIPStcAiaOQWvbclcgs829kU8mh/V9qRkGK1CyGVj4LK1voFXVawRZ1MN7Z95WLVq3GLMRi+K7QFY7VStHP+WLEKgrsVPzKwopUGWayzSrCRs24LFdzBJfz7B/Xz3SHND3dZ0ZlAhqFCoklYcjgLzKnWJzDPGJbn1PFSw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2+aEM8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1FAC19421;
	Thu,  9 Apr 2026 00:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775694463;
	bh=OaWiRFhoHwXD0uAK9BEwKIduuJLM7WDD0Sz53F2Z5Vw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a2+aEM8ShGWHutZICliYsd+9gnDamhT4d48EmWAKdRmzMWJhoXXXfpP0MDFUgT26M
	 +u012DKz/NBoqWQygIn0WPRMSlJwRYuoCt7Ez02eQ6WrUKYaTBnnBWo5VttuAFZ1FR
	 TAy34VXhmuHlHuaw0NpDBOO6dcsCCvZH3DkblK1mivFLHkNoYmUsRD2BINUfnpvEoy
	 YVvlKSpg9sv6AinrtptuywPnSC6SDfLTp5jpZu46IvfGLSEAmQZ/LYFOqQRMuLf1XB
	 wZxomZF2LWJEYm25Ygd8m6RPCL1dEY8ZUuzz96jlNJk8uVBnBxwteKJON+BQZJI11l
	 iunsx5FBE3KkA==
Date: Wed, 8 Apr 2026 17:27:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xu Du <xudu@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 2/4] selftests: drv-net: tso: add helpers for
 double tunneling GSO
Message-ID: <20260408172741.39e65ab3@kernel.org>
In-Reply-To: <CAA92KxmXOpH=CUqEdVV2948XhU1oFh8PBYLUt=ktSsK3sOh40g@mail.gmail.com>
References: <cover.1775527362.git.xudu@redhat.com>
	<b65f95793e03c1cb3ed3af4e1b2bee89fcf7e648.1775527362.git.xudu@redhat.com>
	<20260407080844.35368eaa@kernel.org>
	<CAA92KxmXOpH=CUqEdVV2948XhU1oFh8PBYLUt=ktSsK3sOh40g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-276757-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A4D93C4FCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 8 Apr 2026 10:04:09 +0800 Xu Du wrote:
> On Tue, Apr 7, 2026 at 11:08=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Tue,  7 Apr 2026 10:45:09 +0800 Xu Du wrote: =20
> > > As the YNL Python module cannot be invoked across different devices or
> > > environments directly in its current form, the helper abstracts the
> > > YNL CLI calls to ensure proper configuration of the tunneling device
> > > features. =20
> >
> > Can you explain more? Why can't you use class RtnlFamily?
>=20
> I want to test the gro-hint parameter functionality of the GENEVE tunnel,
> so I intend to use YNL for the testing. I am conducting the test between
> two machines using SSH type. I want to add the gro-hint parameter on
> both the local and remote nodes; however, I am unable to invoke class
> RtnlFamily on the remote node via SSH.

Oh. But that's not really what you're doing:

+def ynlcli(family, args, json=3DNone, ns=3DNone, host=3DNone):
+    if (KSFT_DIR / "kselftest-list.txt").exists():
+        cli =3D KSFT_DIR / "net/lib/ynl/pyynl/cli.py"
+        spec =3D KSFT_DIR / f"net/lib/specs/{family}.yaml"
+    else:
+        cli =3D KSRC / "tools/net/ynl/pyynl/cli.py"
+        spec =3D KSRC / f"Documentation/netlink/specs/{family}.yaml"
+    if not cli.exists():
+        raise FileNotFoundError(f"cli not found at {cli}")
+    args =3D f"--spec {spec} --no-schema {args}"
+    return tool(cli.as_posix(), args, json=3Djson, ns=3Dns, host=3Dhost, s=
hell=3DTrue)

You're not deploying anything to the remote system.
Are you assuming that the remote system magically has the same
filesystem layout?

You can use the ynl CLI but it has to be whatever version is on=20
the remote system. Just call ynl --family rt-link, don't dig
around for the spec paths etc.

