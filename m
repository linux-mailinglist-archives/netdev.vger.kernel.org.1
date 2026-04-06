Return-Path: <netdev+bounces-275629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPR2OK3R02m6mgcAu9opvQ
	(envelope-from <netdev+bounces-275629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 17:30:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA6D3A4BE0
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 17:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 89D433008C37
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 15:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7973093D8;
	Mon,  6 Apr 2026 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egJC01RC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C72026B764;
	Mon,  6 Apr 2026 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775489440; cv=none; b=gtRSJdOYCEGeezQox38kp3O8UIpzic2RBxgYjsQgtItRMOl0wXfM1RuhiPk3BAYYdjOJrgko8udp2NJZPtrYb3oS8aHOsOGY9Cg5ghvOwTRAxVCycxw+AylFN7CiEa5uvUYvKhDDeMNO2FhPPRKIv2K2MbLh6oV4ppE95bQLf98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775489440; c=relaxed/simple;
	bh=LDjJlJmuOzTWy74Nn0yC7pN0AJ7gm1ZbIoZKkfLC0iI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFnkiOkb0IF4kawvOktxskflc5yus5Bupe7iCTpfCnhzrIMaqsVC6O4wsOPXTvVY/SoWVeRBx82ZFVvBNNzkBlvlxiO037VCMfL7bpJNIexahLIdDcow2i3FLln4AtMFgmnSn36/41BB59tWtCLehkwbdqMzoJWFn9JWaoTgKJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egJC01RC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739AFC2BCB0;
	Mon,  6 Apr 2026 15:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775489440;
	bh=LDjJlJmuOzTWy74Nn0yC7pN0AJ7gm1ZbIoZKkfLC0iI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=egJC01RChEg3XaPOJZLzXSgjgNyooqWxgYJ10fX9QHFXMWJPDBZ8AoQus6+iphM8x
	 QF1XzAGmDejTMxAuqUDmxcxpdFd5SS/n5qMUEXI/K2B0K+81euGoXD948aAFfH9awB
	 8McfBmfd4oXw4LjrVGfSFLCSbfSXXVb1vJcweBKlXNZWL4JJc4nuL/ibzGZ0da4mbe
	 OSEh1OKp6lUyUEpbqf2G5NkxE/6IRmnrREtvC4S3P+LOsRQBYaexFU9LTkmV4ZxWtG
	 1aEq0/WiumllW6GY4373jJfsPBFDU5efiR+OwvNFmqcn9l8TMUETEdyM8BYrFvNl+d
	 wcR6BEVNf4muQ==
Date: Mon, 6 Apr 2026 08:30:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, Michal
 Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>, Prathosh
 Satish <Prathosh.Satish@microchip.com>, Simon Horman <horms@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, Pasi Vaananen <pvaanane@redhat.com>
Subject: Re: [PATCH net-next v2 0/5] dpll: zl3073x: add ref-sync pair
 support
Message-ID: <20260406083038.0690bafb@kernel.org>
In-Reply-To: <20260328080624.593916-1-ivecera@redhat.com>
References: <20260328080624.593916-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-275629-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7DA6D3A4BE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 28 Mar 2026 09:06:19 +0100 Ivan Vecera wrote:
> This series adds Reference-Sync pair support to the ZL3073x DPLL driver.
> A Ref-Sync pair consists of a clock reference and a low-frequency sync
> signal (e.g. 1 PPS) where the DPLL locks to the clock reference but
> phase-aligns to the sync reference.

Hi Ivan, FWIW we're waiting for the DT review here.
I suspect some of the DT maintainers are AFK for Easter.

