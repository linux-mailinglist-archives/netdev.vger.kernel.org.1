Return-Path: <netdev+bounces-264152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNEYNanvqGkwzAAAu9opvQ
	(envelope-from <netdev+bounces-264152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:51:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F6820A524
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0599E30620E4
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 02:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E9B26A08F;
	Thu,  5 Mar 2026 02:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfQU6x/A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2348D264A65;
	Thu,  5 Mar 2026 02:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772679060; cv=none; b=Vr4mC5SgNYg4fb/Qm93OONSEKnSGtZIjajiJncnD/Mi/oW0dP5eX8wO2VvTUuf3e8qaEzUR7Tk89lMoWx1L0x+F05tVGzlCxp8ksezlVvGZZTLp4xOVbW8Or5jLalNpH9vQKd02RZptYCK1jePy6GoPhC69GeT81SlXuZ8WMqm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772679060; c=relaxed/simple;
	bh=pUydlp0JDyvoilaKO0EdUKvO26qTKH0x97z1hOtea+k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TR2cXyYtTBs0DC0h9yqIN/8bPh81rNBJ69rMcZEaveI5WgnlwUaIFRHxOz54lD5TJSh4YEOqjipP3pj5JdxqIxTwd6+ByVUUOkZ/Gss0iVXGU2pIs6q1tHLp8ecKQS9EXI6mtR3kagHTzAdJhpWhlM1HOGWr/YipLntEP3eyc3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfQU6x/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8FDC4CEF7;
	Thu,  5 Mar 2026 02:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772679059;
	bh=pUydlp0JDyvoilaKO0EdUKvO26qTKH0x97z1hOtea+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GfQU6x/ApJyFbfHjCkGwdK/UVyTJgS5zf4KaU8s/8c6TZ3AIGRcwxxYSajcJ32mfT
	 /+OcOgSPZ5qH0eaJCPYSq+FsKdU/e9bwwEe8/49PEtRlvG/6vwUJY4ClSQdYv0wTO8
	 ntw7jt600tM0bbDlqWsLVhgxFCwjWHgp0unJSjOCvQ2ljwI0APutDEJ90XzojyHpWi
	 3QKKK1O2ypZXOcCa0QKSZQQEgG/0G+TwiPVeTwVAP0dYFIDeajJ2qUsR/UsCvOJu3M
	 wkIKvrc62sjLCecZB4uudV+76FGov7+W2YpB10cCZx2Ukev2DuR437WAMIrsx2pcMQ
	 Iorhkxsol+eqQ==
Date: Wed, 4 Mar 2026 18:50:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, David Ahern
 <dsahern@kernel.org>, "Ricardo B. =?UTF-8?B?TWFybGnDqHJl?=" <rbm@suse.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Toke =?UTF-8?B?SMO4?=
 =?UTF-8?B?aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, Jay Vosburgh
 <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Hangbin Liu
 <liuhangbin@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/3] bpf: bpf_out_neigh_v4: Fix nd_tbl NULL
 dereference when IPv6 is disabled
Message-ID: <20260304185056.4ef945d4@kernel.org>
In-Reply-To: <ec1fdead-8a2b-475b-a786-846b81234b74@iogearbox.net>
References: <20260228-net-nd_tbl_fixes-v1-0-2b2a274df9bb@suse.com>
	<20260228-net-nd_tbl_fixes-v1-1-2b2a274df9bb@suse.com>
	<0b52257d-d557-4f26-9931-34c81ab621bc@iogearbox.net>
	<20260302171131.28373ccb@kernel.org>
	<0d7bb5c5-4122-4dc9-b52b-c305591207d1@suse.de>
	<bbee1ce1-0615-4be2-b7b1-a14eaf2afe26@iogearbox.net>
	<ba665193-bb6f-4293-b8ca-bbb267e92eb3@kernel.org>
	<ba35fa2c-0085-43c9-afe0-3b2e0351ca3c@suse.de>
	<525dab04-4e64-49cf-94d9-12084e146b80@iogearbox.net>
	<20260304174327.0a48ff45@kernel.org>
	<ec1fdead-8a2b-475b-a786-846b81234b74@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 24F6820A524
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264152-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,kernel.org,suse.com,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, 5 Mar 2026 02:59:27 +0100 Daniel Borkmann wrote:
> >> I presume you mean disable_ipv6_mod which then bails out during the module
> >> load process without error, right? It could be deprecated with a warning so
> >> that it turns into a no-op:  
> > 
> > I believe disabling ipv6 may be legit. Some admins on ipv4 networks may
> > be paranoid and not want to allow any ipv6 traffic if their "firewalls"
> > can only understand IPv6? This is just a guess on my side, but I'm less
> > confident of deprecating the disable knob than =m. I'd be happy if I'm
> > wrong.
> > 
> > To answer the earlier question -- I would prefer to take the fixes now
> > and make IPv6 bool in net-next, feels like too big of a change for rc3
> > :(  
> 
> Makes sense, I think starting this process via net-next is fine and can be
> better justified. Fernando, maybe in that case resend with the unlikely()
> added.

I think Fernando was chiming in because he sent similar patches.
Ricardo, please respin checking ipv6_mod_disabled() ?

