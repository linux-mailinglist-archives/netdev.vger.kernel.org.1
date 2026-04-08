Return-Path: <netdev+bounces-276749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMByO0jj1mkHJggAu9opvQ
	(envelope-from <netdev+bounces-276749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:22:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C5D3C4C26
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE1FD3038AC6
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 23:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C25C361650;
	Wed,  8 Apr 2026 23:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twlSWQdM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7487529992A;
	Wed,  8 Apr 2026 23:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775690563; cv=none; b=dnNi5fYl0GUzJHlqR8EuhoAajp2UYYdCrflSkbIr39LGXv/HYEjGDBh0kju8D0kuDEozhOhhaLFim+6H0aGXVlFVGr/mmbaStQGYO4eHld932jEdEwLICIQxibwjUKkjVe0lnnkjm1sq8h3r/xZsNFsIHJu0lDH8KGIm3HlnzPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775690563; c=relaxed/simple;
	bh=W6SIYq6bwGEHZRRaOowdXsXVWiz89q7IW2um8qqXEu4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWMi3G7vs9QNZIbQ1AK3dYM7bddHHfmNCyfAUrAH52csG2+oa8p+npOjDHkqmiwlGiJumuSKxEyPcg3SbKGvN+TyjKCYLeziOFmke2P7OkYmCMNLae2O+HVSc42sr5qjYW0hZV7GNHnWcHH181qqdFnWqOtlXiWoZaocozhT4LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twlSWQdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55478C19421;
	Wed,  8 Apr 2026 23:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775690563;
	bh=W6SIYq6bwGEHZRRaOowdXsXVWiz89q7IW2um8qqXEu4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=twlSWQdMOe6WC4iCCAy6MxIGOI5KDEZEbMQ4A8sgqhHeJkDBnfXDWWLP6wsi8U2br
	 8/025czocKWwA/WtYsnPGjNJt0UuppBKO+znblPy+6I/uTsS/lSDGltJ49E36GjiC/
	 j3PFBOIapDFHPnavSFDWdScJ1/7mcMLeTa/CYqJpj2v6VkwngSGv8OjDG97zKnfjfV
	 4sGfxUvjI3pe5PdVcCMvgL1XfFh/uFhDTSsPhn9Ucayjm4bzMEOnQ6AWhbor5BrxN2
	 q5ERAeTn+ShZfurIr3J5eb96YN0uRdvmfnhGpqzE4OEN4FneoDrvbhV6cSDJtH3TiJ
	 NDx39zm1Heu8Q==
Date: Wed, 8 Apr 2026 16:22:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v11 14/14] selftests/net: Add queue leasing
 tests with netkit
Message-ID: <20260408162238.16709090@kernel.org>
In-Reply-To: <20260402231031.447597-15-daniel@iogearbox.net>
References: <20260402231031.447597-1-daniel@iogearbox.net>
	<20260402231031.447597-15-daniel@iogearbox.net>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276749-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,kernel.org,jrife.io,intel.com,davidwei.uk,bytedance.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48C5D3C4C26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri,  3 Apr 2026 01:10:31 +0200 Daniel Borkmann wrote:
> +    ksft_run(
> +        [
> +            test_remove_phys,
> +            test_double_lease,
> +            test_virtual_lessor,
> +            test_phys_lessee,
> +            test_different_lessors,
> +            test_queue_out_of_range,
> +            test_resize_leased,

> +        # test_destroy must be last because it destroys the netkit devices
> +        ksft_run(
> +            [test_iou_zcrx, test_attrs, test_attach_xdp_with_mp, test_destroy],
> +            args=(cfg,),
> +        )
> +    ksft_exit()

ksft_run() can't be called multiple times. 

The first run looks like it's purely testing netdevsim. So that should
move to selftests/net. The rest which tests HW should stay here.
Please also move all the setup inside the test cases.

