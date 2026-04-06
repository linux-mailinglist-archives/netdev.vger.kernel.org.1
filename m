Return-Path: <netdev+bounces-275596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOzPEPi202mIkwcAu9opvQ
	(envelope-from <netdev+bounces-275596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 15:36:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A22AD3A398D
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 15:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3956830182A2
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 13:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91862DFA4A;
	Mon,  6 Apr 2026 13:36:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F60258EFF;
	Mon,  6 Apr 2026 13:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775482605; cv=none; b=KmyM/06lEQD49GtMDV4Yl0UfXF79vVcKmVv1n8hWM3lWQKt2DPR9Br+zI/KRqOle//b4ItNANe7jooaDd3nz8jLIXSDb8W2QzKp8YK3akG/632R+7Yf6yqZHq0dB82czgFvld8E+Cc4R3XZYYZZmhrRf3RiChFHDvpjiAzg30dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775482605; c=relaxed/simple;
	bh=SLjsyADKhvtcnlCVDagTlXHmofYOmuF5Nu9OaF/8tzs=;
	h=From:Date:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ply1QsazXZiRZ0CEAdxMAyXwPrixcVJdOdTDa/ykAt6KaT/WW0y8al1s+d0BDiMQImiGLn229AV2hWJ8/AqqP/6mUvPYJcTdNQaxLo2VoQYvAYuF+uYukoUKat60BNSmVcu5UDMmdewnLOVyyTpi1Xbir4CeuE1RiAjjUrW9AUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from reply.eml (unknown [111.196.245.197])
	by APP-05 (Coremail) with SMTP id zQCowAAntwrfttNpmJu0DA--.35068S2;
	Mon, 06 Apr 2026 21:36:31 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Mon, 6 Apr 2026 17:00:00 +0800
Message-ID: <20260406170000.1-rxrpc-proc-confirm-reply-pengpeng@iscas.ac.cn>
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
X-CM-TRANSID:zQCowAAntwrfttNpmJu0DA--.35068S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYZ7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVCjjxC26r1F6r
	13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_
	Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxV
	W0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAa
	Y2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4
	A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0
	II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4c
	8EcI0Ec7CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5
	UUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275596-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.897];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A22AD3A398D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Thanks for confirming that.

That is very helpful. It matches the current-tree ISATAP case in
lib/vsprintf.c and confirms that the formatter ends up writing 51 bytes
including the trailing NUL into the existing 50-byte stack buffer.

I'll resend the patch with the changelog corrected to frame the proof
around the ISATAP case explicitly.

Thanks,
Pengpeng



