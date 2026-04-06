Return-Path: <netdev+bounces-275503-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ouOUEVEG02k3dQcAu9opvQ
	(envelope-from <netdev+bounces-275503-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 03:03:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D15A43A0F61
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 03:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F228730022D2
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 01:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D669A8287E;
	Mon,  6 Apr 2026 01:03:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060773597B;
	Mon,  6 Apr 2026 01:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775437389; cv=none; b=Yg5HGYaqcAfiF1g1Dnc44bkhKO/BbA8Vj6sjzxOqy+Lnek5GBUeAIFbcZi0o7L8koFMB5GMwerWGICiNsO+5uUA+gY52flQEeK1KFjVE5GRNewaU1CJE2OJGxgGFHaPf2y3KrSi/dJTjt/XP20pL4iU8RV7eE/TzKxs/p5PALT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775437389; c=relaxed/simple;
	bh=NaaYS8PXtHT9h4Sss4Nor9sR4h3q2661xa2Olb4QXWY=;
	h=From:Date:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ww+8z447RwdSKj6JlPOkc7CL3CPDuX7jIKB14eMfUQ+ph35egQHE2UGDOyd3h1OIr2t8c7TlN48/Ig31YnA3xZNFL41l/PgPIcx3AebQxAz0mQLMVq5PpKMp9qDdsLtgQkj9jYGzQYAI3XwSlEvucLgVylV1DnxIXj7DQG53EI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from reply.eml (unknown [111.196.245.197])
	by APP-03 (Coremail) with SMTP id rQCowABng9o3BtNp3JgPDQ--.27523S2;
	Mon, 06 Apr 2026 09:02:47 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Mon, 6 Apr 2026 14:10:00 +0800
Message-ID: <20260406141000.1-rxrpc-proc-reply-pengpeng@iscas.ac.cn>
To: David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: Re: [PATCH] rxrpc/proc: size address buffers for %pISpc output
In-Reply-To: <20260404190004.4-rxrpc-proc-pengpeng@iscas.ac.cn>
References: <20260404190004.4-rxrpc-proc-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABng9o3BtNp3JgPDQ--.27523S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1ruFW3Gr4xKr1fCr17ZFb_yoW8JFy7pF
	WIkFyUJw1kZrn7JrnxZw4fW34UJ3s5Aa1UGry5Jry29F15Wr93tryft3WrCF1DXrn3G3W2
	9rZIqrZ7JFnrt37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUWVWUZwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8C
	rVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxV
	WUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sR_iSd3UUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Spamd-Result: default: False [3.54 / 15.00];
	DATE_IN_FUTURE(4.00)[5];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-275503-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.864];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,iscas.ac.cn:mid]
X-Rspamd-Queue-Id: D15A43A0F61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Yes. My original changelog example was too loose, and your quick test is
right for a fully expanded plain IPv6 form such as

  [ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff]:65535

That form is only 47 visible characters, so it fits in the current
char[50] buffers.

The reason I still think the bug is real is the current %pISpc
implementation in lib/vsprintf.c.

For AF_INET6, %pISpc goes through ip6_addr_string_sa(), and the compressed
path uses ip6_compressed_string(). That helper switches to a dotted-quad
tail not only for v4mapped addresses, but also for ISATAP addresses:

  useIPv4 = ipv6_addr_v4mapped(&in6) || ipv6_addr_is_isatap(&in6);

So a current-tree case such as

  [ffff:ffff:ffff:ffff:0:5efe:255.255.255.255]:65535

is possible. That string is 50 visible characters, i.e. 51 bytes
including the trailing NUL, which does not fit in the existing char[50]
buffers used by the rxrpc procfs helpers.

So I agree the example in my changelog should be corrected, but I do not
think the underlying bug goes away. The claim should be framed around the
ISATAP case rather than the plain IPv6 or mapped-v4 examples I used
originally.

If that makes sense, I can resend with the changelog corrected to cite the
actual maximum case explicitly.

Thanks,
Pengpeng



