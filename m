Return-Path: <netdev+bounces-171285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D2BA4C5B3
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 16:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0643A9364
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 15:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7716E214A71;
	Mon,  3 Mar 2025 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mootiva.me header.i=@mootiva.me header.b="UsjgFxP3"
X-Original-To: netdev@vger.kernel.org
Received: from s.wrqvtwtt.outbound-mail.sendgrid.net (s.wrqvtwtt.outbound-mail.sendgrid.net [149.72.121.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05E1213E67
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.72.121.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017047; cv=none; b=tInrIRLxwe+xqeKpfIK7Trluq2Gu6/3IVEcKpuPfjgNTCwdf7GCjnjItij52xIVvKqCA/BurnCMmbXK7R9QOx6dAv3unj+rA6S1f9tmYunnGSFgNFxEzbf9y/aPWnTy4yVKW1exkhEeCtdFJUVfEkCBpqsV1Vz9yd8G6g3rj0bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017047; c=relaxed/simple;
	bh=4QB8mRvJvbJubNCs7xC379ZArhvqKNoXn3qom0oSjx4=;
	h=Content-Type:From:Subject:Message-ID:Date:MIME-Version:To; b=ssEMv49NyxFawTzw090vGJh6btobeQV4t7+8bLanogca9UGTK7MWb5IS/IPECCaxMR0TDojg3q/szAD0woTZHQucb2/cOLiGVmr3xcrcZ9GTBcDhQuFP4Y61/pIHBZx3Ld16E/LWh5AEwo/B+2cpjLcqmhUGNh4qc6TTdQVEo/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mootiva.me; spf=pass smtp.mailfrom=em1903.mootiva.me; dkim=pass (2048-bit key) header.d=mootiva.me header.i=@mootiva.me header.b=UsjgFxP3; arc=none smtp.client-ip=149.72.121.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mootiva.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1903.mootiva.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mootiva.me;
	h=content-type:from:subject:content-transfer-encoding:mime-version:
	reply-to:to:cc:content-type:from:subject:to;
	s=s1; bh=4QB8mRvJvbJubNCs7xC379ZArhvqKNoXn3qom0oSjx4=;
	b=UsjgFxP3/yJd/eOvd3Kof8yuKcXdTYHWXCKTR5ZwQhMX5ayTPr9Vc1bIOS/gDlE2iVHM
	6xLD4aVHYzMc/uifvkBVDWolhIBMSBIKyqy2lucJSmcisrPAKrdLQfdVmu2ZtCv4GPPH6f
	2DkvzGW0WX8M02biI3DBSOa8778/g5GurdmipRnX/Cu0tk/4X03vmW5GBqcS2dr7a/W2A5
	3M0Q7QEOzBLHMZhwKTJb/6Yi4EDXb1BgaEj0H4yMtx8BwABehR71HzHNDFCYu5whVYA0Ke
	xY/NM6B/cI7tgHjtzmDgCgdvbJEq+QDRsAwdTxWsErB2cfWbGKj8QE8bUCPCtCJw==
Received: by recvd-6c59464dcc-gcck6 with SMTP id recvd-6c59464dcc-gcck6-1-67C5CFD3-46
	2025-03-03 15:50:43.794611699 +0000 UTC m=+9397645.042346496
Received: from [127.0.0.1] (unknown)
	by geopod-ismtpd-12 (SG) with ESMTP
	id E0WtqbpCQViSTIE1gwbnbw
	for <netdev@vger.kernel.org>;
	Mon, 03 Mar 2025 15:50:43.706 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
From: Marc Gautreau <noreply@mootiva.me>
Subject: -Taxes 2024
Message-ID: <f9064f1f-0eee-6435-9837-f8b6a1364fc3@mootiva.me>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Mar 2025 15:50:43 +0000 (UTC)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: marcgautreau@lycos.com
X-SG-EID: 
 =?us-ascii?Q?u001=2Em6Preex+jvSVBQjmctpGP8q=2Fk6rX8Rdlg9BepwSP2u3x3nnvczwd0IkFR?=
 =?us-ascii?Q?OyO=2F98HX3=2FDzgtyYGTRkSyh45tuxeSWnQHN1ZAZ?=
 =?us-ascii?Q?bf+pIISagswumkoWPFkUXCfWMGvIoI5vepXezVW?=
 =?us-ascii?Q?EQSlqE=2FHLxO8CAGoJU0tdr4nBC2tlKbM7aIQR8L?=
 =?us-ascii?Q?mamxJlVyipHj3Mq0lEVZ+v8UL9J14iw3SHQ8W4N?=
 =?us-ascii?Q?IEO30u2LC=2FYm8NDaQNxNL=2FZdQwLCfP0RbjtnmvP?=
 =?us-ascii?Q?LP3P?=
To: netdev@vger.kernel.org
X-Entity-ID: u001.2tuiELdrH17+gRp81BBoOg==

Hello,

My name is Marc Gautreau, and I=E2=80=99m looking for a skilled accountant =
like you to assist with my taxes. I have multiple rental properties and S-C=
orp income.

Could you please let me know what information you=E2=80=99ll need from me t=
o get started?

Looking forward to your response.

Best regards,
Marc Gautreau

