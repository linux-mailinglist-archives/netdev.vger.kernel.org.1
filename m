Return-Path: <netdev+bounces-293920-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NfpG5kXHmr2hAkAu9opvQ
	(envelope-from <netdev+bounces-293920-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 01:36:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BD76265E5
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 01:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7615A300BCBE
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 23:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BDD368277;
	Mon,  1 Jun 2026 23:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0PMUSgD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7A4202997;
	Mon,  1 Jun 2026 23:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780357012; cv=none; b=SxseNrjntHg/kNS3vhfpxy7+5o0YUIktIPtMU71tk8UDs22lrVlDfRcSmocvN4uQlnXnUfZFxeHLaiFQaut4PP2VrgJ0G2hfkRrTxF0J39AajC+h2Gt4vooFPiljwBiD4sYg68xbf3f1fkOdmO9klomT1Vs/Ts1ERbKN3mKAZIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780357012; c=relaxed/simple;
	bh=ZtdTUPyZzxTtJ1tC2O94p5w7td5obNH3TudpuAgQ/Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iK2+pRS0Fvmb2q+yEiZxyR6LKXqlj5bG6wE+q4ErM6DBieZQuMXDxsoUHru2TK9dP0vbOF72FYVoNjLTapaMxoLEuR16MoE2O65YP2CCimHUBTfObCq9zxuKfyn89UpmuSZiV9kMG4sK6BGcqEiveouuafwV/i+XjAC7DMKgxhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0PMUSgD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819D81F00893;
	Mon,  1 Jun 2026 23:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780357011;
	bh=EWs8AjuhsLuh+M0atcFB9f1uXtSNa/pWfvDBoxoXZZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=S0PMUSgD5pxB3l47czClaM3J7wXobOLafPbi0sU20b2G+nHtwqwuuHSZ3ij8O4d3/
	 klAprLMOVLFa0eKjKrao8njDu0WKQDh/zKCWM810+thuvijsY6VS/rSiR0ThSkvHd7
	 aGjNskq1m25qatQBtjDE6Uyj2D5LWE7Sqfe42GgXG4srJ+kq9amrnu6KnIK542EMG/
	 wBaS5DxCAv0thkcxYw3owwSpEaeolI/8jT2hN8QYNs3EZPet/U1to6vrXUwMjF+Hm5
	 I8AyBdEc1y2qJCZOmOH2DEysHMjBn/sFLumVbrgW31zoI7vgWfH1dy41J9q7ae/g6b
	 7Djk0NJPmHa4w==
Date: Mon, 1 Jun 2026 16:36:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>, Mina
 Almasry <almasrymina@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 2/2] selftests: drv-net: add userns devmem RX
 test
Message-ID: <20260601163649.50510141@kernel.org>
In-Reply-To: <20260601-nl-prov-v1-2-9bc57d6ca3f3@meta.com>
References: <20260601-nl-prov-v1-0-9bc57d6ca3f3@meta.com>
	<20260601-nl-prov-v1-2-9bc57d6ca3f3@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293920-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,lunn.ch,vger.kernel.org,fomichev.me,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Queue-Id: 69BD76265E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 01 Jun 2026 12:24:28 -0700 Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Add userns_devmem.py, which mirrors nk_devmem.py but places the netkit
> guest in a netns whose owning user_ns is non-init. ncdevmem is ran there
> via nsenter so the bind-rx call is issued with creds that hold
> CAP_NET_ADMIN only in the child user_ns.
> 
> Without the preceding GENL_UNS_ADMIN_PERM patch the test fails at
> bind-rx with EPERM, but with the patch the transfer completes and tests
> pass.

# Traceback (most recent call last):
#   File "/srv/vmksft/testing/wt-17/tools/testing/selftests/drivers/net/./hds.py", line 8, in <module>
#     from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_raises, KsftSkipEx
#   File "/srv/vmksft/testing/wt-17/tools/testing/selftests/drivers/net/lib/py/__init__.py", line 50, in <module>
#     from .env import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
#   File "/srv/vmksft/testing/wt-17/tools/testing/selftests/drivers/net/lib/py/env.py", line 12, in <module>
#     from lib.py import NetNS, NetdevSimDev, UserNetNS
# ImportError: cannot import name 'UserNetNS' from partially initialized module 'lib.py' (most likely due to a circular import) (/srv/vmksft/testing/wt-17/tools/testing/selftests/drivers/net/lib/py/__init__.py)

