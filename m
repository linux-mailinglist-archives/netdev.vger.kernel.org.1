Return-Path: <netdev+bounces-272513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAVVE5ttxmmkJwUAu9opvQ
	(envelope-from <netdev+bounces-272513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:44:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE4E343B12
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05F00312B3A8
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D34B37646C;
	Fri, 27 Mar 2026 11:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWp5A9/f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3A531A56C;
	Fri, 27 Mar 2026 11:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774611522; cv=none; b=NVma8pTj5Z1olVAmL7HMv3M3CvSvfBfYMnUW69NQvrJzzN1/vCbDokt5rZ3zi7ux5aZmHMrf+vsrkEO8e5FtpfkCzkmAwBSdXXyTsbJQWuvOUz+EuUsbgOpDi0IsPFF+seFfEa/ZKU3XedbO2XMVbrmX14iwQjg3AIaXjp7r+HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774611522; c=relaxed/simple;
	bh=Y/In3PPWyQ27YKVvZDsM74MTjLC1TLqYi8sV8yii7hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aAtyc+818yYrN3cCssqH8tLRWwFL9y7LPdwEIyHIblqOrEH3GBU4LYOP6xhyDdX8gz4pXPnCKFNWhEUJxBfbCGR1J+1982ZHS8kEWoqcHioilXENAhyEr632XRpqHSlui/yulC82a1woozNQoSWo/VYb2uvKAgstRD5qnXNYrHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWp5A9/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E33FC2BC87;
	Fri, 27 Mar 2026 11:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774611521;
	bh=Y/In3PPWyQ27YKVvZDsM74MTjLC1TLqYi8sV8yii7hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PWp5A9/fpHSziGYkCt5ZPaYh2GcjqYjJbzIJpxj8pig+NeiG4QLZ2ol+v2i/ptX3c
	 v6gXsbdfByn9pHS5pCLMQuztdK0C7Uu/bNPwRDcFLHr44J4PlcSsVx+COaNlZ8tWZ9
	 074KWXaV/7z3rV59/fchAiTQmp7XhiJTDk+0QDqPj04BniRLsqy1+wAbG21L0IyvDQ
	 1gEbalwvdi6oCKiPD0s5Xy4pBVcI+XkEiPVdqEipNw9TZ+8f0NRaW7CntCw3VqrN6s
	 iNok2lb+MMF9MIG+YYw+07aCR/TuvLbH+/4Gbb8pp75xXkHYc1FFHJI6naYW3JsKjx
	 UQ0J2YYIwL2EA==
From: Yixun Lan <dlan@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Richard Cochran <richardcochran@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: Yixun Lan <dlan@kernel.org>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v6] riscv: dts: spacemit: Add ethernet device for K3
Date: Fri, 27 Mar 2026 11:38:31 +0000
Message-ID: <177461143950.339028.17970705137917996650.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326014617.1011732-1-inochiama@gmail.com>
References: <20260326014617.1011732-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272513-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.infradead.org,lists.linux.dev,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlan@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DBE4E343B12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Thu, 26 Mar 2026 09:46:17 +0800, Inochi Amaoto wrote:
> Add all ethernet device nodes for K3 SoC.
> 
> 

Applied, thanks!

[1/1] riscv: dts: spacemit: Add ethernet device for K3
      https://github.com/spacemit-com/linux/commit/74657a376960252e248089e518cfaaf813906989

Best regards,
-- 
Yixun Lan <dlan@kernel.org>

