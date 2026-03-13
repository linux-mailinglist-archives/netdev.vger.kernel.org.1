Return-Path: <netdev+bounces-267452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kB9RLCoPtGlvfwAAu9opvQ
	(envelope-from <netdev+bounces-267452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:20:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED3F283A71
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9064A30AD651
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 13:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C32A22332E;
	Fri, 13 Mar 2026 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="Ij5fSZTR"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5A51C860A
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407795; cv=none; b=tIhGWZOaXebSBTH24trGQXZVDwiP7dkZ5WG4CIUaWA9m81Rxu0ZTZI0oy3XOiPaN0pmcHPAf7WiywcwM+wDIsVOOvTkclFgrpp54sMIMigIN9Ikp3UUhOY9hlVuhd3eBibu0EVTke1WBrgAKp1Ais3EYKx+NeasQqyfcEavE15s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407795; c=relaxed/simple;
	bh=PTIXyQyDlwPJ3Xof3a3BmfGAp+M4OPOQDCa2TTf6ZqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YsUNb9zKznWnH6xp82oU5xL91kvZgyXo8Jb8lOIhanbnX05RmnCaU4cikyC8uhGgfcGKMF5atPgAw9qMpEo8gREmq1opnUOnnzV/gLnOFqQlDEHfDFsQj87NGThDK6l+dhPXmGGtP5ETXkzOxmII5rYKHnMZrT1s1Z+02YHYB5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=Ij5fSZTR; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from x1 (198.223.13.160.dy.iij4u.or.jp [160.13.223.198])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62DDGPtG073732
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 13 Mar 2026 22:16:25 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=PTIXyQyDlwPJ3Xof3a3BmfGAp+M4OPOQDCa2TTf6ZqQ=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1773407785; v=1;
        b=Ij5fSZTRwLdzKF+NYeq9AGJZ93CQ7ZOCv8TrzhFVoqk3XUSd6fsusio7SjKHXVSa
         9/KU0soicUNVKtfF2R5e14hUXi54a7wStpQWP59JnYVpEgAE1y7u/SxSLWjMP0X5
         FM7k1upwn+1i7QgP/Dd7IIztfvsli21AR5blMvLYawRNIbuxMchdG97rJWMlBnZm
         1QYjuoEJ55xp4VBKZm9rEQPjwmljb+xCi2+OtGWzdlWc2MHjuHU6dHrxUnkMAtp7
         gOd51uchJIuJ70WdwpkqNISN+HTLGzNhp9rN5/70TVO6wGpjDNlsYRHka0/3NYBs
         efy6GBIGqipxsOlh73/ZSA==
From: Kohei Enju <kohei@enjuk.jp>
To: technoboy85@gmail.com
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        edumazet@google.com, hawk@kernel.org, john.fastabend@gmail.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net-next v2 0/2] e1000e: add XDP support
Date: Fri, 13 Mar 2026 22:16:24 +0900
Message-ID: <20260313131624.6562-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312183817.104878-1-teknoraver@meta.com>
References: <20260312183817.104878-1-teknoraver@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,intel.com,kernel.org,vger.kernel.org,iogearbox.net,davemloft.net,google.com,gmail.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267452-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[enjuk.jp:dkim,enjuk.jp:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,osuosl.org:email]
X-Rspamd-Queue-Id: 1ED3F283A71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 19:38:15 +0100, Matteo Croce wrote:
> Add XDP support to e1000e driver. First patch adds basic XDP support,
> while the second one adds support for AF_XDP.
> Tested on an Intel 82574L Gigabit card.

I'd Cc intel-wired-lan@lists.osuosl.org since this series is about e1000e.
Is there any reason not to Cc the list?

