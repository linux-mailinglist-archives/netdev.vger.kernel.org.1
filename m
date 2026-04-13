Return-Path: <netdev+bounces-278068-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEMwE3/j3GnBXwkAu9opvQ
	(envelope-from <netdev+bounces-278068-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:37:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEA53EC0B2
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09133300789F
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 12:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148973C344F;
	Mon, 13 Apr 2026 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V50yf/Uj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278E62D8DA3
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083836; cv=none; b=Y23/xZoZzIZo6B21rlZq0gpdpcdBlKbPoN7RlTLuyGUf6CNxmXAhw7duizV3NVLIUqXpkoMjMgrvBLqo0I4AUkiALIF0Nq5bYR2O1VOPilKTdfWCNl3I2BVHfVEyC9WYM3ccG0/jAzSMzSTbSmxaqPY0SciOdXus7dBVCczktXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083836; c=relaxed/simple;
	bh=BtXUyGAJBLoGMjIfXC8nKb6psyTAKOaBKkJ8gJNx5fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3yqHHqTUum0ASCmGzys73VKv0Z6QGnVvq6EiU+lcHGDnFT3MXy5I74sV4uRbLO+U9i0Fhyx8hQDkIgSwTJ9vj260Zm9ZWYSuGFvRvA4uf+3XmDVhtA4rl+r9J9guuDN23XjZ12qSAlxSiJ1bD0pKh0S6zUweiHETdHAoKABgLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V50yf/Uj; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1271195d2a7so5942470c88.0
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 05:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776083833; x=1776688633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=90bOo6XUZoGgDsOa3XWYgMG0p/UBMe//yktmShtDn1U=;
        b=V50yf/UjDCsIG1brK5C04PGTO78xFsGb74kD4BB0o0lOhaa5VnLs6NylegLU33ydKv
         AffLsxoUty8Ol1Fcc3Be4QrGbaf5Yzgo0/HcnfMpCTOYIbV+yvY8HM1iqnFeor81InlY
         Ik4vAXWDcvI050hkmOrT4Z/eKi3Tv9KNBXoZd1PkWJNTE1PWLNPGLWzxuuQsSOo0XSPX
         LVQEjy88sHBGUEFzRzemNXxalEeq4Ig84vgtAoZxRcckLfVjzBVtmBkYfWicyq1EqU/D
         Uvbjfg63Qmiu7UpUI31k78cRkqHYckSuXOzJMxoVFd02t6+uPfQyB21wrwnH8RROmq2p
         tQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776083833; x=1776688633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90bOo6XUZoGgDsOa3XWYgMG0p/UBMe//yktmShtDn1U=;
        b=rsFAeUTFHnjrGNyqifIPxuZrNGmNB+DkZt6LF3x5ucYFfc2a2UDL1BlwVTaOARJht7
         tn5QCaFDLhcFSP/8KL8QTr4XGcBXb+1o2VGiY31rp4XHHEu8gAAn9moqBJMO8F4ZHFvu
         OyqTIIZd53mKYjYS+hftDouRHSejjDDkQspUjymmu+MV+098dNp3DiuwXbly45kaqVZm
         aoeFjlPNN5ZLvSz70MHGa7x4KDn+uaP4ydY/eWgduBPkmtNwPyu1HurzUKobrKVVAbOZ
         YK53XH3N4BosuW+ngcuyk0AZ4/U9dLsWkI7uCmWGUhxIrT6pBVpXQaacbZsnJ4OqARHZ
         O8sQ==
X-Gm-Message-State: AOJu0YzS6frbxa1DXnbpLPdK5QzQfJ6+Wg3RyvjeeEVD6++C1zxNu99w
	l5e9SKduVQ0/1CUy6pwsgvXs8WJHk77T/u6BvLyvHXwivWs9fQJ0MWN5
X-Gm-Gg: AeBDieuzwlz11VgMyY3Nv+ZcIuUxWX2Yk6BwGiQ347eQmvBy+vBeGkuQpvNRnwJX6ll
	PKrQthX9T8ubp18khXDO/CmHjrvYFxL9e4K/38swZI1yiV+bqewQ/na129D1TOvjYcxR/Cw8dtf
	QPnkzdJIN1V74s1xjWhI31aGmXJEm+mUG4vPNnD6RNMoXw/HYbQ+05F0E24B3dG1VdgrWS+yp5+
	V/yGZ/Nd3EWLYX3wi0K4HPlwbNJ4Lrs9KBDE7lAtwTxU+v69GO4N1J3u6syf108JfSuJC6YofXZ
	mWJNuAjiMitERH31jNn1kbru1RGC+LsXzPzyCoZy9I0PtNGOsUgCscM4mZlaSnih6uWNv57uGfS
	RgAmagd+Xy0dUBuux8TKRUKgfLbIr4q2+D5Jtp9Cf1agE/9EpQfdNP/9QehUjmv13eWwPHKhQOw
	YB0OhA84GLxmLCof79e1aLXj2vS03/Uf7s
X-Received: by 2002:a05:7022:ec2:b0:128:dbbf:fd35 with SMTP id a92af1059eb24-12c34f09a4cmr7189823c88.28.1776083833317;
        Mon, 13 Apr 2026 05:37:13 -0700 (PDT)
Received: from t14s.localdomain ([2804:29b8:508a:1537::3a0])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c34352490sm13109153c88.0.2026.04.13.05.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 05:37:12 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
	id 1919113FAC08; Mon, 13 Apr 2026 09:37:10 -0300 (-03)
Date: Mon, 13 Apr 2026 09:37:10 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] sctp: fix missing encap_port propagation for GSO
 fragments
Message-ID: <adzjdjdll1fi5e6N@t14s.localdomain>
References: <ea65ed61b3598d8b4940f0170b9aa1762307e6c3.1776017631.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea65ed61b3598d8b4940f0170b9aa1762307e6c3.1776017631.git.lucien.xin@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278068-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marceloleitner@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,t14s.localdomain:mid]
X-Rspamd-Queue-Id: 0CEA53EC0B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 12, 2026 at 02:13:51PM -0400, Xin Long wrote:
> encap_port in SCTP_INPUT_CB(skb) is used by sctp_vtag_verify() for
> SCTP-over-UDP processing. In the GSO case, it is only set on the head
> skb, while fragment skbs leave it 0.
> 
> This results in fragment skbs seeing encap_port == 0, breaking
> SCTP-over-UDP connections.
> 
> Fix it by propagating encap_port from the head skb cb when initializing
> fragment skbs in sctp_inq_pop().
> 
> Fixes: 046c052b475e ("sctp: enable udp tunneling socks")
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

