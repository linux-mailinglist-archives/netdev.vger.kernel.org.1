Return-Path: <netdev+bounces-252867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uO8rMZaTc2ksxQAAu9opvQ
	(envelope-from <netdev+bounces-252867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:28:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D8177CAA
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9EFA3003356
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 15:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6012BEFF5;
	Fri, 23 Jan 2026 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfUTAjoS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B53717A31E
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769182100; cv=none; b=bwYQzRx4lqmgYhMHjHv8AxU5qhkGKNIRCYkouQNdLneEGffmJttZnvu14l3kx4S2h/gdWr9UjdeoulKZx24ymOzKhe7Itayzy4PyPeSixFd+1A2pqQPJiHjyOhnWcPwt5DnMQ9UbGHdWbQsWitee6OUFt63a4Q7DOKzb2osRRAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769182100; c=relaxed/simple;
	bh=4Zy+1coUixm4dIbOldT2A6wslodv3S27+hBsZuG0SG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhEaB9jisrqMoS2lMT8NRgqfgHHdM+MWLOjCSvjmVJRSIGxSjNe2+OlZVB1PSLvK3qrtMhjT0nZnLKcQvv5dzTpgKabMLo5ncrOODu702rj9aRel4GxupTkjtMJeRbwT6ToZxn0BmsRwjQmSsO4bqtFI1WcqgJU8cTo75luSQms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfUTAjoS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F65C4CEF1;
	Fri, 23 Jan 2026 15:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769182100;
	bh=4Zy+1coUixm4dIbOldT2A6wslodv3S27+hBsZuG0SG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UfUTAjoSjSbxw7PFMb7CwtsskMCea9cwAtQgC4EH3Sf2U1NtwDwakYsq6YkCgfrPd
	 OyJazTXL/JSvq0ldz9x+o2b2CNHy5FfqBzeqlKL1ntifQUIxPZM9JFLCa2WVq6WEQZ
	 JH4d9P4MXPoLsKlNsdoKHT5mC0Y3lx6Amka5/S3VVDM3F7J3K6uZkFEuAFDPgOCiqB
	 Yueu+BvWb+s0XrB7lRvVYxcYfxGvk6Pz1rFIyUu55VZoNr96JdX8TFANYyrPqCEpWY
	 u3MXMrbM5s609BDLkzAxAANe1yxETYbJtRAbGT6Ian9ma5KbQ4A2pZxoeb0aIYxJDc
	 mNxKjIzle+kOQ==
Date: Fri, 23 Jan 2026 15:28:15 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Breno Leitao <leitao@debian.org>, Andy Roulin <aroulin@nvidia.com>,
	Francesco Ruggeri <fruggeri@arista.com>,
	Stephen Hemminger <stephen@networkplumber.org>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next v2 0/8] net: neighbour: Notify changes atomically
Message-ID: <aXOTj4gp9ONKVnwa@horms.kernel.org>
References: <cover.1769012464.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769012464.git.petrm@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252867-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid]
X-Rspamd-Queue-Id: 54D8177CAA
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 05:43:34PM +0100, Petr Machata wrote:

...

> v2:
> - Patch #2:
>     - Drop the __acquires / __releases annotations at neigh_notify().
>       They are not necessary with a symmetrically locking function.
>     - Retain the R-b tag for this change.
> - Patch #8:
>     - Do not skip the notification from inside the
>       atomic_read(&neigh->probes) >= neigh_max_probes(neigh)
>       conditional. Instead set a flag, and goto out after the
>       notification if the flag is set.
>     - Move the __neigh_notify() call another block up above the
>       NUD_IN_TIMER check. That belongs logically together with
>       the (NUD_INCOMPLETE | NUD_PROBE) check afterwards, no sense
>       to split the two conditionals with the notifier.

I'm ambivalent on the last point. And at any rate, I don't think my next
point warrants a re-spin.  But I do wonder if the same applies to
neigh_update_process_arp_queue and neigh_fill_info.

That notwithstanding, this series looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

