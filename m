Return-Path: <netdev+bounces-257997-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qP8+FN1fimk9JwAAu9opvQ
	(envelope-from <netdev+bounces-257997-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 23:29:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0DA115104
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 23:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E44D330338B8
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 22:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18CF314B8C;
	Mon,  9 Feb 2026 22:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="LzMDKqa2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98012314A7A
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 22:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770676160; cv=none; b=CsL4lJUn1OuTWC07XyeDEIwcP6Xu+7y+HbikjHvvRYgUvQJwK4lHi/agDzzyuwQHO+2VGpAxgmTux7DNTgvKJOrNi6DAftvzkgo2FnRsT0fx9N69l0pgKRkRPzBRIxw47btAPs/4chlkS7viuwM/an7QOusO9TiqmulfmQW8iv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770676160; c=relaxed/simple;
	bh=Nr1N0H3pSkP4c8voFYnmLPhyJBsZyqWCpYU6bfP+hJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ey0Q8ZAMBI31ma6Nug7i9LIL8fPx0Ckg4kY2RIbyzuH3RnGs0ZGjJmr6ET4m5IWy2VNpaNY051MzpGmanFr7WptCVDreWiAJm5g5Z7XP1rPn8uLHoNxTrOI0HvJqg+k+LnDuIVRBKzq7CGvTOiVlc0mftjzpOTItAoenheh0w/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=LzMDKqa2; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8230f8f27cfso2280923b3a.0
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 14:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1770676159; x=1771280959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNxkziu4XGMl5hWhbE+nivct6z2dxKwIWkkdafKfMBI=;
        b=LzMDKqa2eq80BWDRmLxoQ+kYERd3N3rYbuRi9ihD9v/g9Eg694qJFtHHd7nBreD4h+
         cya0lveDSou1Oc4wxK2bPC3KSN1S/qeld+5hxyWF0RsQKRwEklnl9fnaNwLhytduojrd
         cJ8SqEtKjkR4PixgXYDu5pv1F5oGYx2wVdnbHXYkeMP4q5J8Hd6UazawzbQjwUtrV8xk
         0EP1TviWgdmGdQmnbbBBrrHwaeCpwmy6oGOihNSdqD/yp3ZoyTpGvzWoKTOvbKu1K5nM
         keivAU7BNEcqEVUwIU1SN2ivB9WgmkoVcrY6J+6K8BCcfcNnRvrdAIcbNNqeW1A9teKj
         qFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770676159; x=1771280959;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pNxkziu4XGMl5hWhbE+nivct6z2dxKwIWkkdafKfMBI=;
        b=uPs02ZRyqMrt8KcgGMpfMYMZQjSdecvxo6eyJmn7ovbb6FzCRR6yIym3OrcRut1y28
         DzdUsVovhImininVVbJ+Gg8FF7+FxvJZfy3/kIEpy6AV5D49/JOIkg754T5erY8fxzDB
         zIumtLz7nALJDv4kVYAxM958C8cHtoHmgG63/iaMG2+v6QCNuq1PB3dDJG3TiqjLBiHC
         VJ8p3OSvOa6krLyVaOSbA7QlnbdSbGoffq6cWIjElh1QhVF87GMCw3/UDbTetlPq6JLs
         7MjYtI0yWAO67+NuAPUE1zYIc7QJX3OtGZEyPPzxD3ws9wsX7ksSiTrsU9Cyh8cxDKP4
         8/3A==
X-Forwarded-Encrypted: i=1; AJvYcCWfFXcw7vEOtymkRLYjGOqFE0H5uq94NzLhUVScxNW7GbZZmpzBHNjBN+s7ZxPGTznY1Kg0HvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXC/i1KhYfPY/atE2kOJxvje8H08UGu7M+HlFXX6Ntcd9nXoEo
	05qGwj81bS5om3+yBBI3kbbp0+o42QjDWFY8/Px4r7VBRs/kVVE8LVWuYoXNCOXX1cY=
X-Gm-Gg: AZuq6aIE8I9kdpP8W4dwwmaNmUQMz6Nl1nD/7W0NkoZpLKtaSu/UfeCb5cdj+JBynhT
	yUICK90W3gSXInaSwOgbsVI2Agz48f+IVoDR6ZpSmMrIUfa/27WkxCC2sUdTdBgI/J0RBIH2QcX
	3TzWsrWeCxdiyINg0DfMC0l2fVbkTbARS3Rt50XRsBg7DqTHs5/+QubP27sCeCz7Q/6ivh4+rPO
	E0U2uiuGA7xBvU0X35UuIP9dM12mQ2mUR4Hcn/cJV4cusx1SxRo5GM9WBjMov+iSNfSAkSUPE8K
	Qj47s57WHhYLSYfJ7fh6K11sc+Td9vIVF7MwIAPRW6dF2ScgyVl9peF0ejey9zstu103U7KMh15
	J4kc8R/bpk+tbcW9BxYuOBK5j2RgM58eb8HLa4l0QsOXq6MxgJ05BgbRQOKqhJ3kZoCw=
X-Received: by 2002:a05:6a00:23c4:b0:821:8084:f8c8 with SMTP id d2e1a72fcca58-82487a96405mr192390b3a.37.1770676158936;
        Mon, 09 Feb 2026 14:29:18 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82441690235sm11786287b3a.18.2026.02.09.14.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 14:29:18 -0800 (PST)
Date: Mon, 9 Feb 2026 14:29:17 -0800
From: Joe Damato <joe@dama.to>
To: Simon Horman <horms@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx5e: remove declarations of
 mlx5e_shampo_{fill_umr,dealloc_hd}
Message-ID: <aYpfvUPnuItSadw+@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, Simon Horman <horms@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20260206-shampo-v1-1-75b20c6657e5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206-shampo-v1-1-75b20c6657e5@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257997-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama.to:email,devvm20253.cco0.facebook.com:mid,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: AA0DA115104
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 11:18:51AM +0000, Simon Horman wrote:
> These functions were recently removed by commit 24cf78c73831
> ("net/mlx5e: SHAMPO, Switch to header memcpy"), however,
> their declarations were left behind.
> 
> This patch removes those declarations.
> 
> Flagged by review-prompts while I was exercising Orc mode locally.
> Compile tested only.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en.h | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: Joe Damato <joe@dama.to>

