Return-Path: <netdev+bounces-265167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NbLGHBxrGnxpgEAu9opvQ
	(envelope-from <netdev+bounces-265167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 19:41:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE8B22D3F4
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 19:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87E2F300E723
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 18:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E0D38B7CB;
	Sat,  7 Mar 2026 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M11rts0k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6052C38B7B8;
	Sat,  7 Mar 2026 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772908894; cv=none; b=j7PeCASjDsL6aXKonWcQiAyjKaS9gyv8ocK9ctOyIcZqXuYnzyNQeUnuB5t4KCF4ftaheukeKMHToNFPVPA2+n4zaEQR4k4v6dZ2johdHFFXQZTfsR/+beguWG2LxVQHHmlH7QUyqfBgMH2iNq/xpQerdyo7eOicCg5gQw2J7c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772908894; c=relaxed/simple;
	bh=aQJl1UI0uKhZlGzFHId7PJWVoDMdBYctJU3Yed7wPoo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZLq7Apo93E4MDGaFK9mdokOxk9wOQTAavo5Qp0g8NtGl2IUlpJZeVOjltc8psl4dE/r4DHgTOOG44RX8E5F042t6g1BV0peblNSob2iVI+wW25f8Of93XNZPsoF6Qf+ypMTqMgplzKd3I4Prg/7TFGvHYS/e6SFJXyDh52Ko+z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M11rts0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E491CC19422;
	Sat,  7 Mar 2026 18:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772908893;
	bh=aQJl1UI0uKhZlGzFHId7PJWVoDMdBYctJU3Yed7wPoo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M11rts0kei1juFXlDJiS7P3kGanYN7GuXK7lcHmX4aCUnMUNZa1OqbQyTTz/PwBOV
	 b8H+ixDnr/u19E9POfmdDFMKpLzSFtC1sJWpdqLJQ0xcrV8hpxBRabgx5G+eFyj8J3
	 mxx8TAFGbpexHkGyOAesYDtKsxd4nqFKYqAHP2K1Q+fixUtxybYtUZdSybptc1yz9R
	 AifRo4zg5uI9NsB9Eou+Fuz6Dr7qGuQj+C7uR7ufzdkp/23lAcPu3v4jpIA4oIGRCv
	 DftWwa1fR7CI2d/3LofDaffWDvhG2DQ/zCBEvSapJhIni/9VDm5EMF7b45liqxnYsA
	 tk3BnEWw0N34Q==
Date: Sat, 7 Mar 2026 10:41:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, "=?UTF-8?B?QmrDtnJu?= Roy Baron"
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Arve
 =?UTF-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos
 <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, Carlos Llamas
 <cmllamas@google.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/4] Rust netlink support + use in Rust Binder
Message-ID: <20260307104131.4c1d0de5@kernel.org>
In-Reply-To: <20260306-binder-netlink-v1-0-daceb5bc83f2@google.com>
References: <20260306-binder-netlink-v1-0-daceb5bc83f2@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BCE8B22D3F4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265167-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,gmail.com,davemloft.net,google.com,redhat.com,linuxfoundation.org,android.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, 06 Mar 2026 15:12:12 +0000 Alice Ryhl wrote:
> The C Binder driver exposes messages over netlink when transactions
> fail, so that a userpace daemon can respond to processes with many
> failing transactions.

Ugh, now I regret letting binder use Netlink. Should have seen this
coming :/

> This patch series adds netlink support from Rust, then implements an
> equivalent API in Rust Binder.
> 
> As Binder only uses broadcast messages, I did not add support for other
> kinds of messages.

Please no duplication of existing code in Rust.

