Return-Path: <netdev+bounces-113361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 039A793DEAA
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 12:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34D531C2120D
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 10:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A5747A6A;
	Sat, 27 Jul 2024 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9ss1oT7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD76640849;
	Sat, 27 Jul 2024 10:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722075138; cv=none; b=n7VI8Z2xHe+3DNRa3Xc1Rg3Ae1T2Z6FhlRGX294oWtDeRoCvUfm5/3Apfk84Dem8dDxoQ1B7NLRGVZ88H2bKetFZjfOTfnSHhQWzQhLRIAIfqn4fMxT306ij5XGsvTYJ/gs/ZV+vyPlLTrWZC0jMPRm94tY8/G8zZsUbNCJ2hkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722075138; c=relaxed/simple;
	bh=yzQWhc9UVsqsYs8S5zmwtv3vuoT5yk5pRqB0UWUNepA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hkZWXmYRoIUvki/Q0CO2ngZ/C3dwwxUCcJR4HiRD/Y8DiCxBrzZuHWcYvVDNPxHfXxkNoNjVW/gb5AXog2ezRxXoBB4MuzkhkphGo+wPWj/EEZAj+IX1K50Os+hujOKWK4XJp2z1j5CPB0/gyhm4T2hWj9AK3LB4UXzBSkAU1M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9ss1oT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9F1C32781;
	Sat, 27 Jul 2024 10:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722075138;
	bh=yzQWhc9UVsqsYs8S5zmwtv3vuoT5yk5pRqB0UWUNepA=;
	h=From:Subject:Date:To:Cc:From;
	b=X9ss1oT7//lkNP//FGkh4xs1y1oZ+ImwLKRFccgFF7Ynr1FulnHMglD7hUOLDIh0Z
	 g5bIkUwyPJnxFmaYsENItRokmc5f4C1awpimEO3AfWFJmJRrOb8UBi8QRZvEZ57FjT
	 jfBddFDddlVwOhLrTQ6LBmbgWA8zKxY3RRju426Qy3/oWeiLsMD0PTLoODqmdR6HT4
	 DdOrkQ212E0KF7r+PB+rIyebWLti5Zzvce1cZ7chK+q5Jfr4qWYV6X9320wNzjfh6G
	 nWG7rAeLsZbHMjaECjJwcKY+smeNAT5RHubAtRqZd5maw0PdNTQafSUk9arxNd7BE2
	 1QkW4uP30/4mw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH iproute2-net 0/7] mptcp: improve man pages to avoid
 confusions
Date: Sat, 27 Jul 2024 12:10:29 +0200
Message-Id: <20240727-upstream-iproute2-net-20240726-mptcp-man-user-feedback-v1-0-c6398c2014ea@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJXHpGYC/03NQQrCMBCF4auUWTvQRkmJVxEXaTrVQZIOk6QIp
 Xc3uBCXPw++t0MmZcpw7XZQ2jjzmloMpw7C06cHIc+twfTm0o/GYpVclHxEFl1rIYOJCv7mKCU
 IRp+wNhkXonny4YVutIOx1jp3nqDhorTw+3t8g38K7sfxAaOalDGWAAAA
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org, 
 MPTCP Upstream <mptcp@lists.linux.dev>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1183; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=yzQWhc9UVsqsYs8S5zmwtv3vuoT5yk5pRqB0UWUNepA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmpMgAUtpHvMrqqRDbg0oYdd+exT9QWl1w8swhE
 KD4FSk/5lSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqTIAAAKCRD2t4JPQmmg
 cy57EACCiDhek1OT+JhqJlzRFU3TBC1d/gVcQRS+4MpAjbBqdfGeEmv0hms5wV6c5CbIK29dEYr
 GxAh5RPbYUZ/FVMUJ2KUq1TBLjGCSE96tZYBaLFgoDuguk9Qm6RpEHKbwsxl5kkL/XUC4YtTaVw
 +bpPsgK4uzFqmLEPkSDzURK+4G/FCOhBl46LFZ6MKtinKtY/3dTUPTJEVKaypjcDNO5FJ0f/7xq
 94uP9xxpkkdrQdxlhhoksU1RGxgPBaoidXcVTdVqFCiPgPoKg2H6bo+mn6gRYTlmuWzxzQB2EMk
 7pveaTQN/NmsUFlfAjJfGQxYbrxRJ7YEP9oPxiat5/Eb6tRuIvF/kgVhg48h2TBm8ndFgTKrd8+
 Lg7B406NWARnABB+GgyKp43SoaglCWtSdkYTXh1PFfur007DtK+5NVb1kHYlglTklCZJh2JXNpR
 F6LUARb/xrXQ9qFIzLisOmlvZnjwHeHF+d7MWydE6j0lYLaSzve3NNyQ6af0HsvCFy7p7MC8U5p
 fHbKjJxYcDJNWFtp3mZSbIeDExoUHU4iDJv+eCgjMfzeQGw5jiyteOo4P/hKXirljTCKTa157sy
 ETansQltGMx60dWjEVKq7g1aJQf/mKP+JOxhinjCpd9TisGVBUh0Me/TXiyjYV80khfnXC2ZhTi
 I5dzfPVieWP8Agg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

According to some bug reports we had in the past, setting the MPTCP
endpoints might be confusing, and the wrong flags might be set.

This series adds missing info for the 'dev' parameter in the manual, but
also clarify a few other parameters.

While at it, a better error message is reported when 'id 0' is used to
'add' or 'change' an endpoint.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (7):
      man: mptcp: document 'dev IFNAME'
      man: mptcp: clarify 'signal' and 'subflow' flags
      man: mptcp: 'port' has to be used with 'signal'
      man: mptcp: 'backup' flag also affects outgoing data
      man: mptcp: 'fullmesh' has to be used with 'subflow'
      man: mptcp: clarify the 'ID' parameter
      ip: mptcp: 'id 0' is only for 'del'

 ip/ipmptcp.c        |  2 ++
 man/man8/ip-mptcp.8 | 44 +++++++++++++++++++++++++++++++++++---------
 2 files changed, 37 insertions(+), 9 deletions(-)
---
base-commit: 3e807112fdf3d7b89a8295379dd8474f08a38b4b
change-id: 20240726-upstream-iproute2-net-20240726-mptcp-man-user-feedback-97612666993b

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


