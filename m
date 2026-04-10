Return-Path: <netdev+bounces-277573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPVeLXFl2Wk5pQgAu9opvQ
	(envelope-from <netdev+bounces-277573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:02:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DA13DCAB6
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 348FB3024963
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874163A6EE6;
	Fri, 10 Apr 2026 20:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyFpmJzc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B5B36165D;
	Fri, 10 Apr 2026 20:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775854659; cv=none; b=S50FL4JMpM05dxA5J+nE2asxhibQ1B7Eq8ofI4tUYFr7yF9Po+oYwBYYcewV599S45yg98DLK4mNR+1z68+vf8vTg65UeCJCMvtQeTQbzQj4ywxPQwSetaxCtoA6U2VFLDGLj6lnriYd6YbUFZMnHLuS8DAwdsxyYO+XcZ+i2Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775854659; c=relaxed/simple;
	bh=W2GbY85pAkNHR06qR5m8V1VNRajKNuRkVXDevMNWJl4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mjV6J7ohWPdnQ8W2XaGgmQj9QquwZJOstnJkI5iLQ91W3zVr/+WGjDIuAgVsl4sDyQL30oeOxayDhHJC9M0JV5v0IkxE54Ai7tRze9aGfBbzxdxu+fduvD6BOSPRLmnqUHuk+hj861TpwnJzV6zkj1omfOW32RNPQosZVWJpD+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyFpmJzc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CB3C19421;
	Fri, 10 Apr 2026 20:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775854659;
	bh=W2GbY85pAkNHR06qR5m8V1VNRajKNuRkVXDevMNWJl4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gyFpmJzcdBgsFix+zYlWdLwaHklN9gHdTAeCxXZnBTtqL1KAcMAcAUsTr6I75jz9c
	 336hE0LQTDlARiPW2jxdaJuASHns9zd0NP5XAKzhIL8vxVzHwBbqObIQ8FN2DRIz8P
	 rfd/yp96QF3YctHOUMe+Wy2LoAZS1Gw/FvT8C24vDUtgzkvuXCrCmLVs8wBfrD6o4m
	 dTHiHnLSSHyJWn8wbm0lNNivHYJ5xdgF6Z2e7IUkBstCZ+nRvNxzYs2j6W73wmWG5J
	 iUuaSvYLE/RCQ8JzSXOmHVZPgw6G7uAEg4NS1VF6TVR/0U+pkRHG/F4Yy/qA1qw5EV
	 DnkbnQsPRJz9A==
Date: Fri, 10 Apr 2026 13:57:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, willemb@google.com, daniel.zahka@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 jayakrishnan.udayavarma@broadcom.com, ajit.khaparde@broadcom.com,
 kiran.kella@broadcom.com, sachin.suman@broadcom.com
Subject: Re: [PATCH net-next 1/3] psp: add crypt-offset and spi-threshold
 get/set attributes
Message-ID: <20260410135736.4bc7ed46@kernel.org>
In-Reply-To: <CANQF7iDj1E6=3pod078-++5wbweyMg0H7gpeq0kbGFZHNytDdA@mail.gmail.com>
References: <20260406222305.4111170-1-akhilesh.samineni@broadcom.com>
	<20260406222305.4111170-2-akhilesh.samineni@broadcom.com>
	<willemdebruijn.kernel.1d7f9f774aa55@gmail.com>
	<20260407180432.102073cf@kernel.org>
	<CANQF7iDj1E6=3pod078-++5wbweyMg0H7gpeq0kbGFZHNytDdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277573-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,lunn.ch,kernel.org,vger.kernel.org,broadcom.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 16DA13DCAB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 11 Apr 2026 01:06:06 +0530 Akhilesh Samineni wrote:
> On Wed, Apr 8, 2026 at 6:34=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
> > On Tue, 07 Apr 2026 17:37:41 -0400 Willem de Bruijn wrote: =20
> > > PSP defines a 6-bit field in 4 octet units. Does this need bounds che=
cking? =20
> >
> > More fundamentally, were we to support this -- is it a device property
> > or an assoc property? =20
>=20
> It's a device property. All associations under the device will share
> the same crypt-offset.

I don't think there's anything in the spec that says the crypto
offset is device level.
At the very least every L4 proto may want to have a different offset.
We should probably hold off adding this until a real user appears.

