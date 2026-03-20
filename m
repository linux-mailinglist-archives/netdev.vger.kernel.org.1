Return-Path: <netdev+bounces-270104-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLKtI7zTvWktCgMAu9opvQ
	(envelope-from <netdev+bounces-270104-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 00:09:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E69072E23A4
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 00:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ADC3303DAD2
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F75390C8A;
	Fri, 20 Mar 2026 23:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="IeCVo0Qi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F288278161
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 23:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774048185; cv=none; b=l/jCkhIubBJ+XN52nose4pFng4JUS2emMxweEkBT437pvFeIJikyYrwYyXATuZLJnUEgonI0/iE2GxpGLzx0M7X2LyjCjGA/xqXwZ/fm89Tmx7KvpPbrjr10A8fz7sl4IcFKkdtN7/uxnwren8oHacfU0Pp/RE657F0jiKVmIcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774048185; c=relaxed/simple;
	bh=i8xmsS7OGbYPnvSvd73gxWfNZ8allV/8wYvg3WLHCX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuFmo5PLlcLHjbqhLof1+mErz4VOjE/bzhgYb51C2zyxWm9jL3UxgxHBkIm9VEMx/p2aBYa7bm5TCt5gjNxEum2s0sVCeYouqaPpBYT+NFlN1WS/p88VI5nahW8UOLRiC3PlFNeQg0tlEQwyFyzTySIuOV870Y3XOcWYiiqpaNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=IeCVo0Qi; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35a1d4a095bso1455646a91.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 16:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774048183; x=1774652983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUUqCiT6aXukS9SwL9hysllV86yLA5FmYEzwznGMHeY=;
        b=IeCVo0Qi+36moD8fhY8m4uHMxNz+AtdU17fgrx/5Fnhh7KChhb4M81lBtsrflFPnYj
         +GnyQc4GkBrF3v4ik2Zhfemb2z8AAFTqMk4NH5OOy+JVai6IwXZTk9o5B7czQiap0jaB
         coY3ROV5K4ehG8Yr1atxfmAN/aQ2E5v0aNkHWRzaGsvZqMiiUhLUvni7Wf+G6OeF68yL
         Bj0aC1a6fEcwNdOWPKKRs4RhMNE8fCak2h4T3YNPyrt0TgRJlj0oHMLGy5L3wkZB/Z9f
         eQJCWZ9cCYuafqQvzXcAj908JYfx5+Pp76iTMK5YnwG8zNV5Jlnf5zGiH8qAYqqeX6gy
         KMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774048183; x=1774652983;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MUUqCiT6aXukS9SwL9hysllV86yLA5FmYEzwznGMHeY=;
        b=Z+IPujJRvWL6DxhqistQKRhLP+6QPpr9sIWE1exexKm8xcqKTunKiGUUqqHK4CTkYE
         c25CbDV8H2vSrDBIx9fM29ZHMIxG3nRZxA92AB4XuURDGSEamDbIzHHRjvLhDKWniUHO
         tT0KvYGQ284nI2lOR+k9Ewgrb6H2gP+l2Vn6/n6k6n6Lw4cNuA0BqSmpidrNWNNHksV8
         QC5BGDuPBoaJAAo08P0UA2dt5T9PyFluTckfqviPDZdPO0tzK61pKWVSB1WDJNAW0xhg
         mHbH75gZNqMOmu/qcGFIsusoi+0MQgV6bgrmDxdQJn6hZdWccAge68UHfZN3dSO2cKe3
         s+jg==
X-Forwarded-Encrypted: i=1; AJvYcCVLkvj+FwAGbtuSCMDscWyuMjeG3Cu0L9bvil4trB2PgZ5dx1FMQgNXFxMOtmwUZ139NuxOrcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVGnv701jgy8+7a6wfrIHhgxCIwmszWqzrmWA8tqKOt7Mr2b4l
	gvCkrICHlT33Ct1+PkwnA0Z4BYlQRxQbO8xbY/ugN8UiKU4goeofI2ERzYjPkLlMcuY=
X-Gm-Gg: ATEYQzxh8WeVhwq6YHwh4KFK+naUPWjXqooEiUh5yCnKuyvJjlj1XzO/AyjLMkbJBJw
	m3A9yQgLlo1ZjJdx0dd7ejB0IYZi60T5RpmCXaEDzfgER8vrAymwDd0E7YiILgVntWC/UxqGzw+
	4Ru+iI5SEiCROsYCfeZHIXw/ipA8L9W22F3c7skWbtoRhv2Z8OJ1G/zGhNBw09Y3b4hhLPun+3E
	5T5J+DAupicb52pEYEf9xsYg9ZOzMU9dH9+p+Lv1DWBWvw/TknPs+8izpXJjIywT0aLFlE/lbq9
	27qsUAu6j8eEXuZp6VLQVu1zdgWHqVLMxlnPctxSUZrudpIMYdHDIhNMGifO96bUSy9/yRfQ7hg
	mpqxCJ2bkJs6AlDsBjROjJCPKXvN/CzaIgT+FW2oBY2ZzKCX3Om0O0nl3FaCD69oRvBkjP/+MU8
	bEUqqApPqeNNGODw==
X-Received: by 2002:a17:90b:510f:b0:35b:8d89:719d with SMTP id 98e67ed59e1d1-35bd2749cb6mr3212601a91.6.1774048183415;
        Fri, 20 Mar 2026 16:09:43 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd262cb35sm1574549a91.1.2026.03.20.16.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 16:09:43 -0700 (PDT)
Date: Fri, 20 Mar 2026 16:09:42 -0700
From: Joe Damato <joe@dama.to>
To: Kohei Enju <kohei@enjuk.jp>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kohei.enju@gmail.com
Subject: Re: [PATCH iwl-next v1 0/3] i40e: support XDP metadata ops (RX
Message-ID: <ab3TtpEKY5Pg+uQt@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, Kohei Enju <kohei@enjuk.jp>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kohei.enju@gmail.com
References: <20260319171650.5815-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319171650.5815-1-kohei@enjuk.jp>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-270104-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FREEMAIL_CC(0.00)[lists.osuosl.org,vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devvm20253.cco0.facebook.com:mid,dama-to.20230601.gappssmtp.com:dkim,dama.to:email]
X-Rspamd-Queue-Id: E69072E23A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 05:16:41PM +0000, Kohei Enju wrote:
> This series adds support for XDP metadata ops. Since the i40e RX
> timestamps are not available from the RX descriptor in the XDP path,
> this series doesn't implement bpf_xdp_metadata_rx_timestamp().
> 
> Patch 1/3 prepares i40e_xdp_buff for subsequent patches.
> Patch 2/3 and 3/3 introduce bpf_xdp_metadata_rx_hash() and
> bpf_xdp_metadata_rx_vlan_tag() respectively.
> 
> Tested on Intel Corporation Ethernet Controller X710 for 10GbE SFP+ with
> ./tools/testing/selftests/bpf/xdp_hw_metadata.
> Since i40e doesn't support HWTSTAMP_FILTER_ALL as an rx_filter, I
> locally changed the selftest to use HWTSTAMP_FILTER_NONE instead.
> 
> Kohei Enju (3):
>   i40e: prepare for XDP metadata ops support
>   i40e: add support for bpf_xdp_metadata_rx_hash()
>   i40e: add support for bpf_xdp_metadata_rx_vlan_tag()
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 51 ++++++++++++++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c |  5 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h |  7 ++-
>  drivers/net/ethernet/intel/i40e/i40e_type.h |  5 ++
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c  | 12 +++++
>  5 files changed, 77 insertions(+), 3 deletions(-)

For the series:

Reviewed-by: Joe Damato <joe@dama.to>

