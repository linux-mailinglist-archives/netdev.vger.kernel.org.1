Return-Path: <netdev+bounces-185943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C26A9C3EE
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 11:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5F74C0BAF
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 09:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066B7237176;
	Fri, 25 Apr 2025 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="CRGe/ign"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578412367BB;
	Fri, 25 Apr 2025 09:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745573910; cv=none; b=YwGlYYVbUhmT6vXdwmKtz7FYr/EJGnEf0VXQKBONCBJ65g9zvmGn0xPKQIpnsBIB6lDVfqyKP/ud7+P3nIQkMc2F6ZbkDo3oRz6xHPAZ53Ie4tM8fZl+xlfXEDw3HOcciyNezaJvhrUrDpI8u+6+XVH/bslioCDYI2eFY01nR/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745573910; c=relaxed/simple;
	bh=0Y+AxOJ8G++0yS61dGBy4TG8QkXdaWU2HP7zjvc1ccs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=N/IeoaDVkjLIq9m8XyerIXCl6bCvALswRmMJN+L2movOlUAjTiEhUww4W6HVmBNlgUJrjE1hA5AW0+NiscJXM2uXe6/n9DVsbkkCJFAM9lJ5nSPSpLgvfvRVK3dWfZiGGZrCqt/VSAdPppXkTaCMS4XAO2OuUIsEF7jIPeGhU04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=CRGe/ign; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1745573897; x=1746178697; i=markus.elfring@web.de;
	bh=0Y+AxOJ8G++0yS61dGBy4TG8QkXdaWU2HP7zjvc1ccs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CRGe/ign2xGFCJJiyn+zVwjNIcYZIfc4Q6jj520O3Dx/+F3x+VYDdHfiHqeuCO6X
	 rn0wVP0rD+ZC2SuRQVPTISA4Stp/i/MuwidlDiiyIKaXlD+mOG2Fw2bNnGsclH0eU
	 +GKqaXQEeDP0GwNRdvB1jyLyGbNIsAoXR7cUqsN73EkLPKK3TzwM4PeR5keBfvv1U
	 I0fQR42z1jv3cNqwgq2L4ApD5iadNz1FpmG2wJBbDlHzOSCQA2KPIfXGqfr9wuZd5
	 U2OishdZNUhaFupk35kSi4kwnBJxOn/I6t7ynMNPf/6pskuK5x4POw/pTGBfwLEhy
	 hMhKxWyKLhJMI7xoPg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.30]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mf3qY-1ujD9v22VW-00lDgk; Fri, 25
 Apr 2025 11:38:17 +0200
Message-ID: <2fa8f9f9-c0ab-4f18-89c3-a5d48dd4e54f@web.de>
Date: Fri, 25 Apr 2025 11:38:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thangaraj Samynathan <thangaraj.s@microchip.com>, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Bryan Whitehead <bryan.whitehead@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20250425042853.21653-1-thangaraj.s@microchip.com>
Subject: Re: [PATCH net] net: lan743x: Fix memory leak when GSO enabled
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250425042853.21653-1-thangaraj.s@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+F7LkK38TZYUF5fk+395NBeJ85dGuqbE1DRXalZiD18Zmxnj/Qd
 fxW3I2NUEFFMtyeQ6hd1v5qsVixEWWZ0zvg20er3ovNv6JHpVwF5Dx3YWbpTw6R+Z7TMH21
 pR9WAuMJi16wq08VdVLHZSClCZiIaNIo1N4hUEkiUSJGrZxzif0m4Cuj5ZxdNYNP9NdaZZa
 Qv9Fn5UC32cPlc4al6tAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UIHwE8RI6Q8=;C9Q6ekFpx8emmT6gLjj1QSdADgQ
 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
 L6S176bxfyDZ6KaiKbFCFQ=

=E2=80=A6
> implementation has been modified to always map the `skb` to the
> last descriptor and always be properly freed.

See also:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.15-rc3#n94

Regards,
Markus

