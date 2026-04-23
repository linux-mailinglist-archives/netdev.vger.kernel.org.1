Return-Path: <netdev+bounces-280888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMobLf+i6mlF1gIAu9opvQ
	(envelope-from <netdev+bounces-280888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 00:53:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26534458436
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 00:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B982030117BA
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 22:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2306739E6FE;
	Thu, 23 Apr 2026 22:53:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A719138F95E;
	Thu, 23 Apr 2026 22:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776984827; cv=none; b=Vh4CpwTbfIkN85I3gBLNTnQ+L7wJXILIWsjZ05uw0i20EFZ5LQhdeZgJVL+uolnoTnDvqqzO4fIE3WyPPD1CW/cPOqcJisPE5jL5rqB/YM2cSvgmWNPM1EoQfT1CaNoBTD7+WV5QQUuOc0tzVjrmCyzaIlWCAaSUooTxnpVuc+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776984827; c=relaxed/simple;
	bh=sw37xLDtbpY9L+JyNrjEzSqliQryaQ/c+C3DT7He+P8=;
	h=From:Date:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KuHqcrl71+5/oYMzEdAQnioy6Kv6E4yP/HPvAVdQlmZvMARsmgQYocTmq7L0/0NYlhF/3jJFZ005Lk7EfBL4p+Io5FN4U/ic6e4kAOOYfCUSrQg3DkCuA5Aj7+k2z3jU5UYWci0zDzY7YkJEDWlZrs/lrCM+bvW47Fn1SEy5jJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 10-tipc-drop.eml (unknown [111.196.245.116])
	by APP-05 (Coremail) with SMTP id zQCowAC3TBDvoupp4JFsDg--.55062S2;
	Fri, 24 Apr 2026 06:53:35 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Fri, 24 Apr 2026 06:53:35 +0800
Message-ID: <20260424070110.1-tipc-drop-pengpeng@iscas.ac.cn>
To: Jon Maloy <jmaloy@redhat.com>, David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: Re: [PATCH] tipc: crypto: require a NUL-terminated AEAD algorithm name
In-Reply-To: <20260417075353.30662-1-pengpeng@iscas.ac.cn>
References: <20260417075353.30662-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3TBDvoupp4JFsDg--.55062S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYQ7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z2
	80aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI
	0_Jw0_GFyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU5nmRUUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280888-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iscas.ac.cn:mid]
X-Rspamd-Queue-Id: 26534458436
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Tung,

Thanks for the correction.

Agreed, I missed the TIPC-specific guarantee here, including that the
supported algorithm name is fixed to "gcm(aes)" and is NUL-terminated.
I'll drop this patch.

Thanks,
Pengpeng



