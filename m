Return-Path: <netdev+bounces-253147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mF3RM+nddWkvJQEAu9opvQ
	(envelope-from <netdev+bounces-253147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 10:10:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC2B800E7
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 10:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9844E3007677
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 09:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE69279327;
	Sun, 25 Jan 2026 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="k3F046B2"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0E1230264
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769332198; cv=none; b=qqhL88/9EMn3DKwgaeA2u7UIxhMBK4A8H0uuBhCvIm6I2k8UKG65bOn454ZU8jITEcsYJTzgedinmKdU+otfkuKe0nrtjD6uVAnJWb/itW5Z/HrEZRnPY6ue90PL4hdNEgttWGM4kJMFZz49WhOjH8SjNn+9KqKHfTYVYsW0jf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769332198; c=relaxed/simple;
	bh=6DFB/4DZdu+vzJMMuVQ3AYyidak8c+sKX2MfEdUGaUY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X2hem653j50nVQ56bCWCTgKOboUqxPz3znufE/pkDnfHcVn0xAbYYThCd4O+1d9l//KX9MVMYS/zmcceiMD0y6t3BvB5YdkzIURtFeUMVElINoNgZx/FZqZwehd51sfJJSgLaTIH4i4ZkU+0DkAUvKgTM3t3n8t6j4oDycaFQnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com; spf=pass smtp.mailfrom=korsgaard.com; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=k3F046B2; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korsgaard.com
DKIM-Signature: a=rsa-sha256; b=k3F046B2jly3ht8gdu3gQWKV0Tmlfhw+c+SyOeSuM8FFjGShd3bVmvEVJBjY1Gb8oIhNlvzjAn9+kymlATHTFj+CGgAXWAlCFugVp0zRWdyVGC4Z0ZKcnfkLYgH44zL03yVfLW0LZW0yx24Ur6ryIyiyvhT8HssuZ8mEpelBlOCewDAZPrZLyHRdjBm9+0yeImjShMKYBAqVHdLtlis9MxQC656O7apTKXOc49zUhgocuTDCVrLKrWfdw21aR++E6yUgjjWKr7Lg5itUyJ6bw86kuahBpvhQJti4u2J7MjOJv6hIPaM+KwZJRz4Bfjm/mG1tpOyhL+L22WN4x2Pzjw==; s=purelymail1; d=purelymail.com; v=1; bh=6DFB/4DZdu+vzJMMuVQ3AYyidak8c+sKX2MfEdUGaUY=; h=Feedback-ID:Received:Received:From:To:Subject:Date;
Feedback-ID: 21632:4007:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 455626500;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 25 Jan 2026 09:09:48 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.98.2)
	(envelope-from <peter@korsgaard.com>)
	id 1vjw7s-00000001tiG-2fwx;
	Sun, 25 Jan 2026 10:09:44 +0100
From: Peter Korsgaard <peter@korsgaard.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org,  linux-usb@vger.kernel.org,  Andrew Lunn
 <andrew+netdev@lunn.ch>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Oleksij Rempel <o.rempel@pengutronix.de>,  Max
 Schulze <max.schulze@online.de>,  Krzysztof =?utf-8?Q?Ha=C5=82asa?=
 <khalasa@piap.pl>
Subject: Re: [PATCH net-next] net: usb: replace unnecessary get_link
 functions with usbnet_get_link
In-Reply-To: <20260124082217.82351-1-enelsonmoore@gmail.com> (Ethan
	Nelson-Moore's message of "Sat, 24 Jan 2026 00:22:06 -0800")
References: <20260124082217.82351-1-enelsonmoore@gmail.com>
Date: Sun, 25 Jan 2026 10:09:44 +0100
Message-ID: <87cy2ym52f.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[purelymail.com:s=purelymail1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[korsgaard.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253147-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[peter@korsgaard.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[purelymail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2AC2B800E7
X-Rspamd-Action: no action

>>>>> "Ethan" == Ethan Nelson-Moore <enelsonmoore@gmail.com> writes:

 > usbnet_get_link calls mii_link_ok if the device has a MII defined in
 > its usbnet struct and no check_connect function defined there. This is
 > true of these drivers, so their custom get_link functions which call
 > mii_link_ok are useless. Remove them in favor of usbnet_get_link.

 > Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Reviewed-by: Peter Korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard

