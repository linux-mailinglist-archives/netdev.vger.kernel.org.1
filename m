Return-Path: <netdev+bounces-278482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uYt6GHxR3mlUqQkAu9opvQ
	(envelope-from <netdev+bounces-278482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:38:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CEB3FB5FD
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 430DA301061A
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 14:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877FF3E8675;
	Tue, 14 Apr 2026 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7xi0g79"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648FD27470;
	Tue, 14 Apr 2026 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776177527; cv=none; b=nWhKO/5CI0mrn2sGJvbSsPwCqb/e4YRFGLfP8VgnMD/tcQeGJSs62es36WY4lbJ1Esn8pQOQPKilw6P/BpWvfzkH3PIk79Cfympn/b3t3uEnt2ylkj9A97nXGo7lPVfFGRjgg3riyCPO2moH2cLCPEzrJjTpXikrE6eCg8es8yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776177527; c=relaxed/simple;
	bh=SaKNOQNfKw/kzQKlH3xQLY1T00fTHDQzv6EOXYfqc4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlDEdQ2j/Vvpc3k/igG6VC7uaJhzz9zctzaIlh7T0zKqTuqn0BGMK/6ihMvgzZy5KMJIuo1D8/toFLk9/Hxb+WZVvzWAZlDf1939T5Vs7x1di+stGEMVde6Dz24RRUpigkTtCfSoHbljMtFxHAR7JkOcmAaQaWtDegY7ZzqnJ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7xi0g79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF20C19425;
	Tue, 14 Apr 2026 14:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776177527;
	bh=SaKNOQNfKw/kzQKlH3xQLY1T00fTHDQzv6EOXYfqc4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R7xi0g79ycoWhkT3WE0m80xpgZOvBxxKj/DFuI5g4ONtIZXLUigqmplQZa1Gxt1UE
	 bgh395D/HCIHk9BFFcBVe6JMZ5fW+fRgNmDnqJWoRlttm6hW73pSNj5nYuJxqgX6EX
	 zdtOHTnQYQy34DikVPuGZqEx/NvMbIp1/WGFY+AZEQrS5ZLSC3E081MDRWqbpQ5ti/
	 GomAnBCWAAyfJU6j5bKpp+pX0sDKpY2FOxDGKS8kt6h0ObI2puZPGYDDhY3CpHXagX
	 2uktJudn1CLy0cTQGtYZcl658cwk0bfV4v3ncoTHkQBQUpFqiX/+KL83Nhhk/DceDm
	 Y7sk+tIVw+DHg==
Date: Tue, 14 Apr 2026 15:38:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the origin
 tree
Message-ID: <a2749894-503f-41a4-98c9-2442ad22ff9e@sirena.org.uk>
References: <ad4whCJuB-viVAae@sirena.org.uk>
 <CAADnVQLz6-LK4+qad_XqEZXrspttpe4b49jRZ6wUCgEhJeTvgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r+G3QLXOXTpIj1Yj"
Content-Disposition: inline
In-Reply-To: <CAADnVQLz6-LK4+qad_XqEZXrspttpe4b49jRZ6wUCgEhJeTvgw@mail.gmail.com>
X-Cookie: Academicians care, that's who.
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-278482-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_ALL(0.00)[];
	FREEMAIL_CC(0.00)[iogearbox.net,kernel.org,vger.kernel.org,nvidia.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 46CEB3FB5FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--r+G3QLXOXTpIj1Yj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 14, 2026 at 07:09:44AM -0700, Alexei Starovoitov wrote:

> But how come you're saying it was discovered "today" ?

> Paul's commit ad6ef775cbeff was committed to rcu tree on Mar 30,
> while Kumar's 57b23c0f612dc was committed to bpf-next on Apr 7.

> "today" is April 14.

> My only explanation is that rcu tree was not in linux-next until today?!

We're in the merge window, this means things get sent to Linus and end
up in his tree.  This in turn means that they are seen in different
orders, and sometimes depending on context in different forms.  -next
is merged sequentially, it's not an octopus merge of all the trees at
once.  Some variation of this will likely have been seen before, but not
this exact combination.

--r+G3QLXOXTpIj1Yj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmneUXEACgkQJNaLcl1U
h9CTlwf/V5apJckYAKX8vqhAGBW1VKms7zFRTDVsiDnVZX3+uA0WBLw51iyXSIlB
Y59qk/2neBd3KbzoqqM2fBI8+x4+XYvkM/J82+xBuWm39brlQ0JT2OrI4/ZUb4W3
zC73vs5Bf+NEzkPcmH883gCa9KcC+5bp49vMOrOn0mTwITsgqQCsdUZ+R+8fW9sx
5YteqtdXh8EHKrCF+yqo/mqWVVjCeBqNWg2bLjl/R3KmicP//WrMsJ5Ix4BwmnD8
/nMGTLbSSQSdtUfRoUfFu28a3Kt6lYCHRIahkovNfQcliR54pTjct5oOjrpMqbLN
3sIc1nQkmtuVhgxU1eYwJbZPQro06Q==
=enOS
-----END PGP SIGNATURE-----

--r+G3QLXOXTpIj1Yj--

