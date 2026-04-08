Return-Path: <netdev+bounces-276352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Ae7FjQQ1mmxAwgAu9opvQ
	(envelope-from <netdev+bounces-276352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:22:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5573B8ED1
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B865300442C
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 08:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F02639F182;
	Wed,  8 Apr 2026 08:22:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C8A39F17F;
	Wed,  8 Apr 2026 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775636525; cv=none; b=cKWR0qeZnDeMHe8z7/VpO/XPa5z14L2XaX1QVcm1eHr/cfI4Lsk5zIKy5osD0NCfgmuALWjgy3ew2tzTA6MGGwr/YGqRibJn8iwjjSGIcgixzf/90gVGvmZGcBFQpD/jINSHUU4Ee49dmuXNi25L5D3mvdBpw2l8WfV/Wpct6j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775636525; c=relaxed/simple;
	bh=6I5ZYI/5LU2yAJ0YoiSJlGNcSfVH5fFo2I5cIPGfgnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PjAsH9CLRVsqHYbuf+r4J5MA+OwXjNl2vlcddiYROixlcGtTJo4L1rmhaWFpFzjWKtpcqNrMQmn1Zp/U7I8ZA2OhLdD50b1jyCTz+ogip2pEdgzus1/IXhDAE4yQMXBEsVXVNwsBdgkbUVkJS661p7EGTpbAV5YJ+3PiKlLKRqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from reply.eml (unknown [111.196.245.116])
	by APP-03 (Coremail) with SMTP id rQCowABnh94kENZp481YDQ--.40944S2;
	Wed, 08 Apr 2026 16:21:57 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: David Howells <dhowells@redhat.com>
Cc: linux-afs@lists.infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: Re: [PATCH v2] rxrpc/proc: size address buffers for %pISpc output
Date: Wed, 08 Apr 2026 16:21:56 +0800
Message-ID: <20260408171000.1-rxrpc-padding-reply-pengpeng@iscas.ac.cn>
In-Reply-To: <20260406170001.2-rxrpc-proc-v2-pengpeng@iscas.ac.cn>
References: <20260406031157.72866-1-pengpeng@iscas.ac.cn> <20260406170001.2-rxrpc-proc-v2-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABnh94kENZp481YDQ--.40944S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKry5tw13Aw1kGr15Wr4xCrg_yoWfZrgEka
	92kF4DC348Jan7J3ZIya93KFW2g3ya9ryrA397Xrs3G34UXF1kCa1DZr9xtryrtay5tr93
	Gr93ta48C3W2gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r1D
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbb_-PUUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276352-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.960];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,iscas.ac.cn:mid]
X-Rspamd-Queue-Id: 5E5573B8ED1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi David,

That's possible for some builds, yes.

My concern here is a bit narrower: with the current %pISpc formatter, the
ISATAP case can produce 50 visible characters, i.e. 51 bytes including
the trailing NUL, while these helpers pass a declared char[50] object to
sprintf().

So even if a particular compiler/ABI happens to pad the stack slot out to
sizeof(long) or more, that would only be incidental code generation slack.
It still writes one byte past the end of the declared object, and whether
that lands in padding or in another live stack slot depends on the build
and the specific function layout.

In particular, rxrpc_local_seq_show() has only a single local char[50]
buffer, so there is no source-level guarantee of spare space there either.

The patch is really just making the object size match the formatter's
actual maximum output, so we don't depend on incidental stack padding.

Thanks,
Pengpeng



