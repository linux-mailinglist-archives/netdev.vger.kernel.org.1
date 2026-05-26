Return-Path: <netdev+bounces-291875-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPV8MiTmFWrdeAcAu9opvQ
	(envelope-from <netdev+bounces-291875-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 20:27:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6664E5DB55B
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 20:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B71CC3011379
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9648440DFAF;
	Tue, 26 May 2026 18:27:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FD6421A18
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779820064; cv=none; b=n7qEem9nnL9Qs88/HmZ0huzJgnfQlGfv+Jjiw+CDwikHRDCPz5CowscJS7bHd7QsFoU9vOSphVFILdJNfgv+2AUSyxunWovbiBVwbF89SMH+CaqBEQTCod4V5RsyXF5awsYUnc81yoZN2uHXv8nPLry+d9uCu0HV7toJxsZXTiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779820064; c=relaxed/simple;
	bh=qnEyiN5u94/41O9QO9WxqSZ7r8D6BDUT3NnBsTYeLmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuyxRmA8dCz/o4XARjUdGcwdosczHJH9k6cO0n02aevUvL+Z8pIQhd/3NM3JRPTYtwBAIcbdNrx5KvJL6t9V4owPpbLhPkI1008uhiu/dMTkmgWc57o63swX2V62D/Jtw951N2hx6SZXucIEVdv8zDxMvCqV3PQmvyfvPJ6E7Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45e7c636e74so5814010f8f.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 11:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779820060; x=1780424860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0Xjm65d4RA9kC6fH+CTvtbYudzgt6xtf0Gx9rb/6JI=;
        b=lgJGRUxCv2zYjCvNRJUgwMeqyPoOqWX57U00++kU8kQlNZtERNloFwlgUa/diwBPjG
         uijt8j42CiYfNIzBe9txL05ppWiVONutQhi6xikOLgHEa04EWDZzcmxBpZstkyG6U+TW
         eQ32PJHkxYsJx78qV451L+YFHflqnbOxzOjEoZoNNRS6ScNPi0LOCgeLyNpePAxvWnkE
         tsWF4iwP5TLt1ovy7qDe1O03MSiTGYYNCaQVzBNZ2jBAvnKCsYBeRb+FSEe6QoE6cWqL
         MZCNeYn5qFvg1fHAXpxkyoptHZPOIbPIW7+gEs2tkw44O+4OEsnNqKH86oHoF/WMJQMu
         NSww==
X-Forwarded-Encrypted: i=1; AFNElJ9YT1jJrwAQ6K5dizNCCPRQRZjwKgNUAozoaffDsPCK1tF9kaBUKQfD22yi710ReFAGB87I3AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1626Nk701mB7CEmkcSzlomdrz85Xp7V6BukmAF0bDN7FNV3Q6
	nnAtA9vu6B661PFACPE/v3NvaowrnUXzYcxDwE+Q7ahY3eBTe1slnM6d
X-Gm-Gg: Acq92OGoUkKV0R3yWbjheQbnBe7oKFO7yku1lE0nLShHAb2iDzviHGpjxgFYvWoiMFA
	rX8QZnr3KO/ErybXAY9xJePif1U6iDESGzCRtJLnUmEMH3xHB4rIga/rOWgFg/sqx2sd1Eyif6U
	8keqI1aPLfsuPkZFePwfd7QrRSCVwfSW407OUPmlXudH1ZRLQ7lCKXI8xTAB3/rIU68C+QEYOlN
	IJWWK8GiXhtJ+bKOJjVOMRLlBK/0Hq4dvTnC1MLz32tgGteRI9zZ6eJWsJXPix2D9/zh6hE9bmu
	+aoYCdwVPs5wEuXRkwYx65KH8Yb2gmAo8bGukPOICmum4bJobJlPtoqt1qK5E53ypuhSGYlY382
	ipVFFmRF7b/tHH+2VSK74kwNVNEsVt1K/VYv/4tHDRY8CJLg6xWJwyq7TCnTldDjVRfxo2OwFc5
	f/kFKchPjbzhRLB2x+hhGXiVbWCuvRgjcw9Q4V
X-Received: by 2002:a05:6000:470a:b0:43d:3004:5fef with SMTP id ffacd0b85a97d-45eb367fb4dmr26397188f8f.7.1779820060171;
        Tue, 26 May 2026 11:27:40 -0700 (PDT)
Received: from gmail.com ([62.197.47.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb557545sm91361f8f.12.2026.05.26.11.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 11:27:39 -0700 (PDT)
Date: Tue, 26 May 2026 19:27:39 +0100
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	David Heidelberg <david+nfc@ixit.cz>, Samuel Ortiz <sameo@linux.intel.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	oe-linux-nfc@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH net v2 0/2] nfc: llcp: two fixes for nfc_llcp_getsockopt()
Message-ID: <ahXlNRH6Bzv_4_gq@gmail.com>
References: <20260521-fix_llc-v2-0-ab44cc09179c@debian.org>
 <20260526173351.GB2256768@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526173351.GB2256768@horms.kernel.org>
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[debian.org : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291875-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.900];
	TAGGED_RCPT(0.00)[netdev,nfc];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6664E5DB55B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Simon,

On Tue, May 26, 2026 at 06:33:51PM +0000, Simon Horman wrote:
> > Changes in v2:
> > - Guard the length check against negative optlen (Simon Horman / sashiko).
> > - Add patch 2: move llcp_sock->local read inside lock_sock(sk) to close
> >   a UAF race with llcp_sock_bind() (Simon Horman / sashiko).
> > - Link to v1: https://patch.msgid.link/20260513-fix_llc-v1-1-33c76f931ff6@debian.org
> 
> Thanks for the update.
> 
> There is an AI-generated review of this patch on sashiko.dev.
> It looks like it flags pre-existing issue that doesn't directly
> impact the intent of this patch-set. So I don't believe it should delay
> progress of this patch-set.

Agree, and looking at what sashiko raised, it seems reasonable, I would
say the state check in llcp_sock_connect() is incomplete, and
llcp_sock_connect() should refuse non-LLCP_CLOSED states.

I will send an independent patch later, if we don't hear any concern
from anyone else.

Thanks for the review,
--breno

