Return-Path: <netdev+bounces-291014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBUcBxENEWpJgwYAu9opvQ
	(envelope-from <netdev+bounces-291014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 04:12:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9C05BC7E5
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 04:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 749A930305EA
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66D63033D6;
	Sat, 23 May 2026 02:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7t6sf+F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219A82F9D89;
	Sat, 23 May 2026 02:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779501872; cv=none; b=A8XuX/4UPh9n3vD4nkEN+dJT7ZqIx2PCnPBp6BT1/v5qqT7OgPe9rZGnLmb/Z2HY7bXFyRR06EKLzd7IP0T7+WeHb0lw57+zjw9PAFR1BUXfKshvamXypGfaVoaXOlqM3pXX5TjzlP5gNEFulUtH9r6+VVyN0qJf44vGpAaj7HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779501872; c=relaxed/simple;
	bh=fGi9yGlZ0q5byT9au7IMWauGYrYhzbWbLQITkJV6E7w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=txT+OlAL0Sqvg31usy3zZBy7AmcE+VsPCfJFL6zzropTJdgRarz/p0iw+MTwGtd+F21AtpeA//YH4CvmDDrQT2+e8+xTE5lmTYPCkfjFdRM5gtY3pu0A5f9lH2SQBvny3LMTR0JjGSiJLXLJNmwyhv+D5V+fSTG8xbeeGwR1I6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7t6sf+F; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E24E1F000E9;
	Sat, 23 May 2026 02:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779501859;
	bh=fGi9yGlZ0q5byT9au7IMWauGYrYhzbWbLQITkJV6E7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=n7t6sf+FE3vP8YoQyqI6cQjY5Xwhy43e2uYq3BJAYWWXOGE6+nwl9RpZ4/d11+jg0
	 oHM7ek+V4xerdzyfgCeYhSONxgfJDY6c/d6pS8re2du9BKaZ5c+mopSUlfUVwqyNoB
	 DLuutO7wOMbiLEjXQNxt0ANC/droPABZD/gIkqJjCl1l/7XSDXwguZJtPRbboGcmxj
	 VFWfXARJtbOALWWHl8xNA7D6H6NaCLVCt11VNAnTfTEhOpdilGPDGlR9BlK3umhHSq
	 3HQHYJfKMaYxfrNEA4OZbSmChQ7x4/Z+dJDHHB+r0iynHRWY4MQn8ghaUJeFZkMNWe
	 hBrE0HvxITvOA==
Date: Fri, 22 May 2026 19:04:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jens Emil Schulz =?UTF-8?B?w5hzdGVyZ2FhcmQ=?=
 <jensemil.schulzostergaard@microchip.com>
Cc: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Woojung
 Huh <woojung.huh@microchip.com>, Russell King <linux@armlinux.org.uk>,
 Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next v5 0/9] net: dsa: add DSA support for the
 LAN9645x switch chip family
Message-ID: <20260522190417.53ab9cc4@kernel.org>
In-Reply-To: <20260518-dsa_lan9645x_switch_driver_base-v5-0-968fbf34ffa3@microchip.com>
References: <20260518-dsa_lan9645x_switch_driver_base-v5-0-968fbf34ffa3@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291014-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,armlinux.org.uk,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6E9C05BC7E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 18 May 2026 14:24:55 +0200 Jens Emil Schulz =C3=98stergaard wrote:
> This series provides the Microchip LAN9645X Switch driver.

Looks like this needs a rebase.

