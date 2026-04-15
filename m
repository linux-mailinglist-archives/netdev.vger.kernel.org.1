Return-Path: <netdev+bounces-278740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBBHNhdo32lSSgAAu9opvQ
	(envelope-from <netdev+bounces-278740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 12:27:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB49403476
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 12:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA02A3004CAC
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BFC322B8B;
	Wed, 15 Apr 2026 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="OU3amlUQ"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B12314B9D;
	Wed, 15 Apr 2026 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776248777; cv=none; b=u6jkHrnyS513l274F9wJLNL5cdLQ9a/d7/vM6bgZ0081K81ujqFU6aVA465mY/byqNWRccZ+SpUSsSj22eVUhDiP0sd8J+sVZHmqnXud4Gij1mWMpA2nK4iXukOVtwwx4355Mgz/o9XhQgUmNsO0R07Kj0O+BhIyxqwJoLcdrmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776248777; c=relaxed/simple;
	bh=WUnFtqMqBwiQmUTfjICkfjVtSGlHuFpTjc9sHdxlaxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpGDAS/i1z+tp6g5eil1jR0NGU8WtKI35t18KnRlUc7iVviKnw+Z24Vy6Q38OCPJNl2148TO/C1j/+yXcqGeRPlr88nFUaJYsDp++fzbvRsZO11yRFIWYpOuGPdIEAfbRmbLyI5xfKyoaLSHcs1YxL85HKkvFU94f6VOoImiOYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=OU3amlUQ; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mrD7p6MJhVAVx6u8xXz0QG9VMVnUTAIfPFAq0M1Vv6Q=; b=OU3amlUQTKjS37WD9mYssvvkZZ
	0+9Cv+jy23UrYrkx53/mISbJpY1iSgsdXrU/d+uXN5Bs00FM8Wp4pcvSiIXPMqKCCJXJOZyFU7rFD
	3ZUWmXD3pbIK74+VfbdF4dZmXXpfpqPyeGPAG2AMBSk98MKQk/RvQEU5w/laMhI/JwtU56PojDrXF
	NVGiUR/KBSZHYzhlczDkA0zE3NdWbANIYQ99GVohe7hTuOIDH3PbUiXur1cr2B0MuAZ6dvSMQccpM
	t+ofSABY8r/rU+u6vP09RTYh9sT9e50PuAxQZdpbWE/98aVZV0RvgaiXyLN5B7DGxscjEm2UG8k7i
	Xi9yrgoQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wCxRd-00DlvM-0M;
	Wed, 15 Apr 2026 10:26:05 +0000
Date: Wed, 15 Apr 2026 03:25:59 -0700
From: Breno Leitao <leitao@debian.org>
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH net-next 2/2] selftests: net: add FOU multicast
 encapsulation resubmit test
Message-ID: <ad9hkJXAnlv2ZUm6@gmail.com>
References: <ad7MsSJOuUU6EGwS@dau-home-pc>
 <ad7NhoxmrFJAsXe7@dau-home-pc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad7NhoxmrFJAsXe7@dau-home-pc>
X-Debian-User: leitao
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278740-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[debian.org];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,kernel.org,google.com,redhat.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DAB49403476
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 02:28:06AM +0300, Anton Danilov wrote:
> +send_fou_gre_packets() {
> +	local count=$1
> +
> +	ip netns exec "$NSENDER" python3 -c "

Having Python code embedded directly in the shell function makes this
difficult to review and maintain. Could you extract the Python script to
a separate file? This would simplify the code to just:

	ip netns exec "$NSENDER" python3 my_python_script.py

