Return-Path: <netdev+bounces-290996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKHrKK4AEWprgQYAu9opvQ
	(envelope-from <netdev+bounces-290996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 03:19:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 231175BC4A3
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 03:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 892E53019FDF
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BE71E8826;
	Sat, 23 May 2026 01:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAt4axvb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697DA1624C5;
	Sat, 23 May 2026 01:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779499178; cv=none; b=kaN77tPQl1JjYfRiYAIZeLzlCW2ieNZFA4J/xMUVxzYa+xGLEk0deJwyyK0wjZN0ZG+7Bm6GI35J/Rb1wX+RDmUszz23/aLSLrW1xvhUVlXahqdGjQpf/q/o0K5G4CPTznTFBtfhSR3HHNByqDWvudl606qaPE4qPW7zNSknrOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779499178; c=relaxed/simple;
	bh=Mq0MHBj+Uu57Au5fdhUFiYPynK1lzVkojkNikz45zlw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qRfSljWrgWANeoPJXFOu/FRZIIKoSgt1qMp/rpqjKdvqSsDh+SSPBGmOYmn9Rebh9/d+XwtfyMTHaS6G7MCW/DgmqCC7q0+en8P+2JXKJuXpIqeAEAkFhAee2fvHsrcK/1tegL7aYhUTfzRdI8XeoUf3IpIk7Jrl13zIPDzJ644=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAt4axvb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0551F000E9;
	Sat, 23 May 2026 01:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779499177;
	bh=wJpuRSkdCX/Go60XI/NiTm0+/zsRB1KApYOPW4VcEdc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VAt4axvbXKIlGL1UUZJChz70gv5bTzrIUUR8u9dc32VpB6ZQPInUwm65GfrXGxuet
	 eaVCBQ12CUYOixn5ZXSu15yQ3E664L9oUH47jHQsxobWeAobsN2ly/1naNHyI4jDjA
	 XQODcnagj6vA4V4a2frYpnIP/bkwVxgDEadGqXCrLY5l6XCXFOXe1eIp22oCbMEgdK
	 mdohX9eQ2YDi1PTW0URcPEjN2kI+hUDTBzm6lgxeJyjs2aGTJuCYveQ9nhhZx9OXZl
	 dv+BcwCqz1aGqhZgySPX5O7Z09v3idc9bJ2N5l5ecBPiVbyIk2dlBzUhUCPgmCsxsH
	 j7Qu8yVhWMW3A==
Message-ID: <585a18b53dbd2545224185a9f4d9f9c05ddc7e24.camel@kernel.org>
Subject: Re: [PATCH net-next v1 0/3] selftests: rds: ROCE support follow ups
From: Allison Henderson <achender@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com, 
	horms@kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org
Date: Fri, 22 May 2026 18:19:35 -0700
In-Reply-To: <20260522174601.3c2c2b46@kernel.org>
References: <20260522215430.3748226-1-achender@kernel.org>
	 <20260522174601.3c2c2b46@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290996-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rds_tcp_run.sh:url,run.sh:url,rds_rdma_run.sh:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 231175BC4A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-05-22 at 17:46 -0700, Jakub Kicinski wrote:
> On Fri, 22 May 2026 14:54:27 -0700 Allison Henderson wrote:
> > This is a follow up series to the "Add ROCE support to rds selftests"
> > series.  The first patch renames run.sh to rds_run.sh, and also adds
> > two wrappers to the TEST_PROGS target to run the same test over the
> > rdma and tcp transports.  The wrappers rds_rdma_run.sh and
> > rds_tcp_run.sh also provide self-describing names that appear on the
> > netdev CI dashboard.
>=20
> Could you make the RDMA test return XFAIL rather than skip when RXE
> is not available? We try to use SKIP for cases which are easy to
> fix, like a tool missing. We won't be running RDMA tests in netdev..

Sure, if you want I could also drop the wrappers since rds_run.sh defaults =
to tcp. =C2=A0
Then patch 1 would just be a rename.  Let me know what you prefer.

Allison


