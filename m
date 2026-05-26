Return-Path: <netdev+bounces-291679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KP1FJmaOFWrUWQcAu9opvQ
	(envelope-from <netdev+bounces-291679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:13:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7F15D55B3
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B6B33011A7D
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EECE3F7A93;
	Tue, 26 May 2026 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBN1jLKQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5913DE452;
	Tue, 26 May 2026 12:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779797594; cv=none; b=CyRAzO1KbtS+pTgamjZpOPNV2sAX+iOhiZbAV8nNpfxtoVysKdoxnLQRSPswh6fpLwVx3KbEtBddCjprAZBp2x6S+If823v4z49WLyRQYJ6N5OmPdyp3mWLyvEI4sGroK71jDdaX4qkSY5a8DTqhUXrK4GehLycHblni8kGHWmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779797594; c=relaxed/simple;
	bh=xdZ95vC7Fq+5QOpWFwACtL945TcKENWkRlGQAi3Pqxw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c07BkhLhVjplTx60So/KqxmqU+7ptx5D645viAf06q9mQPC0YQi/jTG2ra5AiboIjmfdMmPpA+lDvTqMYaX7gE0IFyKiudGVmI69lKL6e4snrGjv0LPjT5r+DKdvh9rUDgC80U9kN8UatFZiGHBwYuNfPQ4zNe17Hw7v/cOmcxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBN1jLKQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027D71F000E9;
	Tue, 26 May 2026 12:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779797592;
	bh=/PlMCsG58Og/BWJOZjzosw89h+7oCgPRyFVhhD89mOI=;
	h=Date:From:To:Cc:Subject;
	b=MBN1jLKQCBE6osvlhdtm2gMvYGTR31Mgw0Yp7GGqU+Zs/I1YW0R+dAl3oP1a2XowY
	 fSPytVz0WjsDArx/y0bM6y+Jqv4gYgpAy6kShRwXt8E9xsXGUieeyPdYgDmN/sJBWb
	 ioGcCp+AsU0gCgxHUg2ZgYLe0ZjiCJlRa/OtnCxjeDpqFWsAF8f4+tYMnKYEOW5ngi
	 RjkEt4srnx4jzatcU6VXLp+HQxB51mhwcO8jmVsF0AseQt980u3nOiciAtlfnsl8J9
	 gGQhG+K57EFQUMeCM2Bn35K95HQsB9RghNlKXTNKNgtxyAAhbgQGvsG7l5/Au8OqA4
	 GJG4D6RswMEiQ==
Date: Tue, 26 May 2026 13:13:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the bpf-next tree
Message-ID: <ahWOVFZZScPjm2Ow@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9IyIlIE3sgCOvARk"
Content-Disposition: inline
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-291679-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,etsalapatis.com,iogearbox.net,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6F7F15D55B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--9IyIlIE3sgCOvARk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

After merging the bpf-next tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

/tmp/next/build/kernel/bpf/core.c:3379:13: error: redefinition of
'bpf_arena_handle_page_fault'
 3379 | __weak bool bpf_arena_handle_page_fault(unsigned long addr, bool is_write,
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from /tmp/next/build/include/linux/bpf.h:9,
                 from /tmp/next/build/include/linux/filter.h:9,
                 from /tmp/next/build/kernel/bpf/core.c:21:
/tmp/next/build/include/linux/bpf_defs.h:12:20: note: previous definition
of 'bpf_arena_handle_page_fault' with type 'bool(long unsigned int,
bool, long unsigned int)' {aka '_Bool(long unsigned int, _Bool, long
unsigned int)'}
   12 | static inline bool bpf_arena_handle_page_fault(unsigned long addr, bool is_write,
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  dc11a4dba2464 (bpf: Recover arena kernel faults with scratch page)

I have used the version from next-20260525 instead.

--9IyIlIE3sgCOvARk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoVjlMACgkQJNaLcl1U
h9DQlgf/Qig5mKcOhHHXLfl4Pmy3pnzesly2426k2yGQRac+Onu751S42w8jdSYd
dx4sT0+FWhIxFt8sHJILnqOxyfgZDT3RTJmOYahCRU8Gbns5sycCl77uAE6EWhUP
Kw3QFrNORAuMfqkrYy7JrblJwK2MDL1X9yzMXmUMaWUFWCclf7UqeWk5PL5c608N
wrV1wvEyaLVf+bJx0PS+gHj4rsxc77bXjJT2D5+AxnadOK17ZE0OdpW2zOkMw9v+
6xXd0ADyikNOuwhst/kQsmbSMrsS8Vd6fYSk9CaGfvZ6Py4OB/wRnK3jdE9FHKe+
I+9uonfnxb+PEv6fKWEl3DCGae+aOw==
=QxUj
-----END PGP SIGNATURE-----

--9IyIlIE3sgCOvARk--

