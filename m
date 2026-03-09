Return-Path: <netdev+bounces-265782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CWWICtNr2noTgIAu9opvQ
	(envelope-from <netdev+bounces-265782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 23:43:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4FB2424EA
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 23:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12D88308CBE6
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 22:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650E638BF8F;
	Mon,  9 Mar 2026 22:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4/qKMMw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4032A37D130;
	Mon,  9 Mar 2026 22:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773096214; cv=none; b=onQ8pTd1Wa3FXKXTpT8s2ftmuuUHYJS2WJwg7MIorSETwCHYTh7jEzGzZpqrjmJYS25OIi35JBnFD0eba/+WKiP4dHoCODJ2au3YqGY5MeV1scZwjxJeFWZYFzSUrNU6EbElpf7NQZaH5XgROcTujx5shXMR99aH6WCFtjiL8oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773096214; c=relaxed/simple;
	bh=V38z9eqXI0xiuUXgdMom4+2ldVRgsTJ3Ln2d6Dyn0oQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HhyJsNqoUCd0x7h+1Wyofm/vGS9nGT7Z9XCfRTR6Cp02PYR3DI/+uSe6InC3cTMtwbI1pR//U1mM3WeiXZCyqMstXG5eReV/woo5p5FGJn3pAV58ZUJVdezPRUJF0ctbBDbRwwk8Imz4fKoBRNaAVZrMdP3O28TvQyHwttCNWpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4/qKMMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB6EC4CEF7;
	Mon,  9 Mar 2026 22:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773096213;
	bh=V38z9eqXI0xiuUXgdMom4+2ldVRgsTJ3Ln2d6Dyn0oQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=U4/qKMMw7SX+m77wuUqNZtFnNoNRfw4ImCXMLqW7KpwNIxQLLSPe+/CucHdN9p3zX
	 LWqnI6oNrqDvw4vdRg46JyiATwEBqR2Yymbq/yYOqosvxqRYl0pHVCsOMGZ2QZRRON
	 pVD872iIHob9mJuIYJFkiCRgiLk8KL1EGstlSVZ/7rDk+liuhmRg6Lv/MUcsHum3Tx
	 PGs5S/AP+nBhlobqMxX06aUYbVn3hfkDauJxsXHGtu61A7sM+ZVxiZKGc42P+vfqCn
	 ORbx6TnVWENTR33DDvJQfp0hhKyL0RKb2cUJtuO5P8oF1U+Mf0cdKi/D0IWc3FbDrC
	 Hz54mipyu8Tcw==
Message-ID: <1e617ee5e6003994d41a0a270ed1f6b17ac75f8d.camel@kernel.org>
Subject: Re: [PATCH v23 00/22] Type2 device basic support
From: PJ Waskiewicz <ppwaskie@kernel.org>
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org, 
	netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, 	dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
Date: Mon, 09 Mar 2026 15:43:33 -0700
In-Reply-To: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: DC4FB2424EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265782-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ppwaskie@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Action: no action

Hi Alejandrom

On Sun, 2026-02-01 at 15:54 +0000, alejandro.lucero-palau@amd.com
wrote:
> From: Alejandro Lucero <alucerop@amd.com>
>=20
> This patchset should be applied on the cxl next branch using the base
> specified at the end of this cover letter.
>=20
> Dependencies on Dan's work has gone and also on Terry's as the only
> patch required is now in next. The other dependency is on Smita
> patchset
> but it does not exist such a dependency as that work will not avoid
> the
> problem with Type2 and DAX/hmem if soft reserved memory. This needs
> to
> be solved by the BIOS and Type2 UEFI driver for populating the
> CXL.mem
> range as EFI_RESERVED_TYPE instead of default EFI_CONVENTIONAL_MEMORY
> with the EFI_MEMORY_SP attribute. There exists though a dependency on
> one Smita's patches:
>=20
> [PATCH v5 3/7] cxl/region: Skip decoder reset on detach for
> autodiscovered regions
>=20
> This is needed for the default behaviour with current BIOS
> configuration
> where the HDM Type2 decoders will be kept unreset when driver
> unloads.
> This is the main change introduced in v23: committed decoders will
> not
> be reset. Previous v22 functionality supported first driver load
> finding
> committed decoders but resetting them at unload and supporting
> uncommitted decoders in next driver loads. This will be suported in
> follow-up works.
>=20
> v23 changes:
>=20
> =C2=A0 patch 11: fixing minor issues and droping change in
> 	=C2=A0=C2=A0=C2=A0 should_emulate_decoders (Jonathan Cameron)
>=20
> =C2=A0 patch13: refactoring unregister_region for safety type in Type2 AP=
I
>=20
> =C2=A0 sfc changes: slight modifications to error path
>=20

I've been able to mostly get these to work on a very boiled down
driver.  I still need to port these into my full driver stack, but
moving that whole stack (multiple drivers) each time a new API is
proposed was becoming a blocker.  So I have a very basic driver that is
testing the interface against our HW for now.

I have a slight issue that I'll address in Patch 8, or at least ask.

In the meantime, I'll start moving things over to our full stack to try
and get the same level of replication.

I'm hopeful I can start adding Tested-by:'s to the patches very soon.

-PJ

