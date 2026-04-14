Return-Path: <netdev+bounces-278436-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EYoJ68w3mnxogkAu9opvQ
	(envelope-from <netdev+bounces-278436-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 14:18:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D8D3F9EE6
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 14:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBF3F3023D91
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 12:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6543E51F8;
	Tue, 14 Apr 2026 12:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acvcYm0Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FEC35B633;
	Tue, 14 Apr 2026 12:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776169097; cv=none; b=Sbd0gDDIHOfI4UpKCSIfml+759tTdPL4T8XI863aeJFATSJa8hU0uDICPG7to+/9XZZO45GY73Dtu4s2BjhFX9tl5nNdGK1ErFj3bGIHnHW5k1UjZMvNpkmLfSu9wXG9WHZMYc9Bp3LZ+VTibVhASh/rraY6LiRg5SptbPt0S48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776169097; c=relaxed/simple;
	bh=4gn9oT3Io797IMn6UnyTmbEEIEuxg+1BvCtywthXl40=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AnKw0WQD4e0kego428fbjdwAv6rKjk/I+jZLd2E64s5fhhqlh/dqS7RvQesNvErflAtzA2yDaO/hZuW5tmv3yJbrIlsEe/wsbM7/2YMCkTbz4SASvlBiq5K1fnMe65pfTaj/KeynyZWAjlQr8Xxym6YkYoFlPWu+KS6p1BnB9ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acvcYm0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18826C19425;
	Tue, 14 Apr 2026 12:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776169097;
	bh=4gn9oT3Io797IMn6UnyTmbEEIEuxg+1BvCtywthXl40=;
	h=Date:From:To:Cc:Subject:From;
	b=acvcYm0QPOU+ysbDfBpUPQ1wr/Fn+6i1NhhNlu6a2KzKH3yN0mrfTMLQyj5pzr/Vc
	 0MYQ1xA+WyoQULBEuwLd0BjQfec/sy5RAfqSw5FMGf2fV/tjbsWR7pJ5HxjBCXRcK/
	 rZciD0mgiwLVGbPKaVvwZH2sDro/rKZJfcKCbMns8hKiH1+4uqc2sPhK+2umhzoMdu
	 HlDaKc4us9fxGuTecpRQF00XDZwm/cKgBy7SblfcpaPkGXvoIizdz8MXpozyRy/eja
	 BCwN91FgZ1olRla/Dv1nTIRZqF/FY+FkBLLTXY+KjE89aMfqB1X5mVYOD/uK8A6G23
	 vyErC0xDRqr0Q==
Date: Tue, 14 Apr 2026 13:18:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the origin tree
Message-ID: <ad4whCJuB-viVAae@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ssHmiU8O+IQxzZ3+"
Content-Disposition: inline
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278436-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,vger.kernel.org,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Queue-Id: 54D8D3F9EE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--ssHmiU8O+IQxzZ3+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  include/linux/rcupdate.h

between commit:

  ad6ef775cbeff ("rcu-tasks: Document that RCU Tasks Trace grace periods no=
w imply RCU grace periods")

=66rom the origin tree and commit:

  57b23c0f612dc ("bpf: Retire rcu_trace_implies_rcu_gp()")

=66rom the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined include/linux/rcupdate.h
index 18a85c30fd4f3,bfa765132de85..0000000000000
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@@ -205,15 -205,6 +205,6 @@@ static inline void exit_tasks_rcu_start
  static inline void exit_tasks_rcu_finish(void) { }
  #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
 =20
- /**
-  * rcu_trace_implies_rcu_gp - does an RCU Tasks Trace grace period imply =
an RCU grace period?
-  *
-  * Now that RCU Tasks Trace is implemented in terms of SRCU-fast, a
-  * call to synchronize_rcu_tasks_trace() is guaranteed to imply at least
-  * one call to synchronize_rcu().
-  */
- static inline bool rcu_trace_implies_rcu_gp(void) { return true; }
-=20
  /**
   * cond_resched_tasks_rcu_qs - Report potential quiescent states to RCU
   *

--ssHmiU8O+IQxzZ3+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmneMIMACgkQJNaLcl1U
h9Bpuwf/QKDAkJrSAPQ80+ExxzxCI8BNzZdRC05PUG52TynImnik0wsGYuaECe6t
teQPkUVhzEa+TsIIYhNOtHy25LV7yNmnWrlxY2x14cp+5sLeePqkgkiQVqhcOYyZ
rZru/5i4M0vqgnaHOG9iC5AaFmOan8BIwkL+LF1p+6bmgzasqHuK8Wjm2s5aTfsk
H5+mv+1Rm5RxACcX7bup/ak7QquTJPSKqpBNuXjiJRJ+ccK1kN8vgRN6sXzakRx7
8iLsOmZQ1VRpy1JjyIP1QQMmH2SyaFGrcY3piHV4YHWRGQYExwoSmpWCppxhzlkE
MZk4/NOcZBJoYFgmS1+qk7Snc4NZFg==
=rWQ8
-----END PGP SIGNATURE-----

--ssHmiU8O+IQxzZ3+--

