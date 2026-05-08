Return-Path: <netdev+bounces-285886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIRoGWz9/WkdlgAAu9opvQ
	(envelope-from <netdev+bounces-285886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:12:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFB24F8694
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19A363159F57
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 15:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C4140DFDD;
	Fri,  8 May 2026 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZprT7Gbz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F17F3FCB0B
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 15:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252633; cv=none; b=AgZjKJgWCl3pfzgOm+n70d9xM47+V8KpJfW+wE7XO8npkkoa14jHoLDjo8N1Io4FntKNfiU5yieuELHChCe8zcZW8HE+Wg3GptkR6P3ubRfv9EF2DWtTFAWeHrhFdBZ7o6eGNElWPmNLMmOt1n3XSAQ5X8+QwkBWPz/c1PtkmKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252633; c=relaxed/simple;
	bh=KD3nw7Ltczkx1jI5uovKefPtMpE0/TaBF2VlVH6+8Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X021+TzXIAUy1w/iaxGGmg1Ih1+SU6KirbDaQpW/TVN0k1FUXtIDGjxXh8T9ACpfbiTzEWDxpdjzOgecxl2xNKnopifK6ObOSqm0TzZeKB3O3aHOXSeCr7rxlfNASyadfxuO5YgILtc5q1gwX8eWeXOw/k7VBpCkJv/I1LnVIqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZprT7Gbz; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2b9705613ddso13862535ad.1
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 08:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252631; x=1778857431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=du2JzkQKqlNU0D+Gab0Zj7x2Js35Jp0EtokGh0n5n4I=;
        b=ZprT7Gbz23RwV74LMuTjFmcaqjhFvlQTecnvgQAQLFEnUpd0aHMYunxGW4YNy0VxWr
         HG5MKDlj52fiHFcmw6Tgx/T9QUKf+6i6SaeNE0yvX3x8xD53kOF7sxaItyX4yev9AeNC
         22CH6q02MVLexWSx+nXSLfWTuxvsa34syJ1i7Tld9x97W95X7UK5oiWuuvbygP8wqZNl
         on43jDx6CMT3zkR5RXESsBKizjtCzQH/Zy/aBpsqisGxcSWQaAHadH/JlYssp7zPwopt
         2y0/bsWPBjgyPtea5ttmqhXa3ofs5cOXAF5CZfR5j0pqQ33ongsMZwtz5+VFYsrqaJAH
         1yzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252631; x=1778857431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=du2JzkQKqlNU0D+Gab0Zj7x2Js35Jp0EtokGh0n5n4I=;
        b=XWBQigytfEf813rZfl/vBCymIwXuNMh6Kilx4vcJ0M+F3rOoL+N4Y4ORa3BbQdUE1W
         4uJAanOumnmVOddpYA/qlLrrC8Bga9P0cFhf0UFL/VsUZTy7O0U5GSiIeLLbamkimPU2
         shGLRWsex/oN1ZRqw3HEZKmcrskh1Jabzz1KluG6DK5ZLdxgq1abdnV3RRyHq9laRRVj
         49V356AQCjGlU3Sve2+LG+4xAszLlb17rMNBvnyQdypecp9G7Bqr/OJk71KOWQZ5izHZ
         eQsxBC9crAV+0noxYdsyBhqcFA4x60fETMa8QYTAbXXTdSmnYmbHy1vXcJjnucjACnih
         MfZA==
X-Forwarded-Encrypted: i=1; AFNElJ/cSXkZfXeFlbNJ76R5bSztu/7KvNSaVZUKwnOHQxWF3yUBCuDzq2n37oooOo85F33TnHS26XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzRRZkwaWjqlik9R2OlN2vQLLvU6ve7tQoz1M9doLtEmgr4Dq+
	8lffJL9tmkyTkj3C+pENRWmLFQkxiKSAT6Zu4ycBwNwuFc7R/uu5XnJh
X-Gm-Gg: Acq92OGQaJ6FxDlJzitlQ+RwfHmeg+bv3arPDVpJAIj2vHOEO0mW+5PKNCZ9WWY5kI4
	6PSWVZ8BAkIunQN6E2Jod3D3AlBv/293XL/biPLfynmsfF9UAeR5rmmUZdJB0xtxnZDI4z5kUqx
	rZSXvS7aGdCSaB2MOV7YXoAxBm1XJSyDsdUjC9VTnd8tmJztQ5i70eEinBsCCW5IzpSCTiwWzx4
	oQaZ/uKbqjni6Xkge+GXkV4U/3wqKxyg991q/xZSLeLfUicA60FZues3IWg5B7NRRD+Li3m4z1J
	WwXe0f+1OrjMh8HH01MgTixOE6Vq0Q3uYGsegAIYT3+W4UCLEogCYpYOmfOabvOJ59cYnj/FIg7
	OIh+oBi8/FyW52nexfpP/h9nHea8sx3AH8gP1xq1+feHgVu4o55DpWg7uyTBiUXtzRyiWFXM92Q
	F/su++JsyKEpSsBB9PwpDOzm/tdBM=
X-Received: by 2002:a17:903:64f:b0:2b0:41bf:ca83 with SMTP id d9443c01a7336-2ba798c27a9mr92826425ad.23.1778252629752;
        Fri, 08 May 2026 08:03:49 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:49::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e9fd64sm22598665ad.69.2026.05.08.08.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:03:49 -0700 (PDT)
Date: Fri, 8 May 2026 08:03:48 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Shuah Khan <shuah@kernel.org>, dw@davidwei.uk, mohsin.bashr@gmail.com, willemb@google.com, 
	jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, wang.yaxin@zte.com.cn, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 8/8] selftests: drv-net: add netkit devmem
 tests
Message-ID: <af37TYtuxGHh7crM@devvm7509.cco0.facebook.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
 <20260507-tcp-dm-netkit-v3-8-52821445867c@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260507-tcp-dm-netkit-v3-8-52821445867c@meta.com>
X-Rspamd-Queue-Id: 0EFB24F8694
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285886-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,broadcom.com,nvidia.com,fb.com,meta.com,iogearbox.net,blackwall.org,davidwei.uk,gmail.com,zte.com.cn,vger.kernel.org,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,nk_devmem.py:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email,devvm7509.cco0.facebook.com:mid,nk_qlease.py:url]
X-Rspamd-Action: no action

On 05/07, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Add nk_devmem.py with four tests for TCP devmem through a netkit device:
> 
> These tests are just duplicates of the original devmem tests, with some
> adjusted parameters such as telling ncdevmem to avoid device setup
> (since it only has access to netkit, not a phys device).
> 
> Each test uses NetDrvContEnv with primary_rx_redirect=True to set up the
> BPF redirect program on the primary netkit interface.
> 
> The NIC (HDS, RSS, queue lease) is configured once in main() before
> ksft_run() and torn down in a finally block via cleanup_nic(), mirroring
> the nk_qlease.py pattern. This avoids re-toggling NIC settings around
> every test case.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

