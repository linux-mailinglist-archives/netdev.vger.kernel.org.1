Return-Path: <netdev+bounces-216929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B7EB3630E
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD672A6155
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E4127707;
	Tue, 26 Aug 2025 13:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="RH8x/3qu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HhBTBlLV"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3739A1ACEDA
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214215; cv=none; b=Gl0rBWLjQLrZDBJFBSFKNRF5o/U/JmPC2Cq3pN2uDjDMzrdiwWdomSSmyZb5BVROZ9DIGaZfp2f7+bs90SFWoF10NLCWFvEuj/LTrRUcJ4qad0kghIHxoZa1TGfNQ5HBaZ3uElpeS8+5P45OlN2LIbAVzdY5/O42nPzjKsFW8qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214215; c=relaxed/simple;
	bh=l4TJD0yD2uSP52k376cJargIHrFvfOzFo3bMsmcAXzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kOq+eHSQFT8cQsLCRSXMRLuhxTINiTargsA4AvfSBQOhj09cjDvg5nEQnjQ0XnMHLnSGMAeyYL00NxaokkNaTSGcaOnPR2Ilmv3oUTtvWAHISPl03mqKLeFKV/Gl6nXQkRA3ZYjP8pAMCm0WVPzpTZx7GAjilnsGPQzJ5WbGYP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=RH8x/3qu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HhBTBlLV; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 294EB1D000A2;
	Tue, 26 Aug 2025 09:16:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 26 Aug 2025 09:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1756214210; x=1756300610; bh=bs4L2UNhtO
	2dm5cWBBFKqxfwTcZV8gVkA2w/I2FSVFA=; b=RH8x/3quw8Sr7QxxJO0Cp0kEQv
	dt/yZcIBJFjPAOoTy4mvkhq/pH8cTD3sFhJIMgYldaYEJ+fkJ3oNtUrcVorUNrpS
	7Uo68SqH1uMnUUZ0TE7dwCXekDi1HCJ64XGkDZf6tKTiLDpxkcC+HTwtRnZFDrd5
	xuE5YoLDqV2Dlhk57Tbf+fb/nogbBX5qyuv4euXhpwtC+VX4GntwVOGBx6ADJPMF
	izUhrKBnJEsTI9gAqS6vLS+VYGHG2Gor/FMJZMz9lE6h6xcXwbAqvhRJd97ji8He
	C02/82P7jd+HoKKK0Rayxc6vS3sVGrsyVStCYODChGyVqU5JqdXDGapHne9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756214210; x=1756300610; bh=bs4L2UNhtO2dm5cWBBFKqxfwTcZV8gVkA2w
	/I2FSVFA=; b=HhBTBlLVklY47+cP9xPcwe9LPc5s6wgAy/5nsepB3JOcAj5K5/4
	rT0FwCQUd4eoLTvOK5urdCQRI4+yCG047WGZt+8esO5fJbtsGKjRnLm1d4zcqp9i
	Lau716Yc56GxAzDWdCOMRt4hbWcC2UhOLG2D+SkrCH9HmSagiLUrqeYb2ACMFiUu
	9k5OeGrN+132rx+1Z/lmMe4X9MF1jPM2lI6xE/tpXjBkEnUuQ3DJXyFaNDaoB8mp
	+6S+tMpoBKhIvPTXinrZu1D8uLq+Sb2Ce8J2LR7mEcKZmfae3RTzRirrauMbetkq
	QOPugWPN5v8DxQlLciU+T0pqgEV+ZaGwfIQ==
X-ME-Sender: <xms:wbOtaNTT9N84c8a_z32ho-B4E92gG_NrqW_u6npPoYMSmm2LupuogQ>
    <xme:wbOtaG-fR6X5n1PvbPYedAjEbehsYxCEJcjJT6MQQcVsxpBeguZWZ2De8efLmLCZG
    nciJLCrtvY6hQpXhJw>
X-ME-Received: <xmr:wbOtaErl6hxRbXNuwz4d7HYVEqX2k9XGMzvBu3gkBZYFuiSAlKIsbO47Wi19>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeehfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihs
    nhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeevgfeitdetjedtkeehffetjeekte
    ekgeejtdeiudejleehgeeuledugfehveeltdenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    gusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehsugesqhhuvggrshihshhnrghilhdrnhgvth
X-ME-Proxy: <xmx:wbOtaDmaAtChz5xXbb464vNNeUi_14qbL8WYuEHlEbsKmTyP9cSdPw>
    <xmx:wbOtaLLLzh8kngWopm8JWi6omqrgC17BsyofiH1lmPLT48Ym-dt_lA>
    <xmx:wbOtaIxZu1WglpRtPhyoSXymDrs8uo8l_2e6p07Oq-9kU9PrTIFG4w>
    <xmx:wbOtaDvgGnrHhPrPc4j28wjToXf0xalN__vtftw-14gssdL2i0K7Jw>
    <xmx:wbOtaH1J4Gt_XSz2MwMHnfYykc6zmrXhOFFxgzVcytj3GNDhj_pM3zKc>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 09:16:49 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next v2 00/13] macsec: replace custom netlink attribute checks with policy-level checks
Date: Tue, 26 Aug 2025 15:16:18 +0200
Message-ID: <cover.1756202772.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can simplify attribute validation a lot by describing the accepted
ranges more precisely in the policies, using NLA_POLICY_MAX etc.

Some of the checks still need to be done later on, because the
attribute length and acceptable range can vary based on values that
can't be known when the policy is validated (cipher suite determines
the key length and valid ICV length, presence of XPN changes the PN
length, detection of duplicate SCIs or ANs, etc).

As a bonus, we get a few extack messages from the policy
validation. I'll add extack to the rest of the checks (mostly in the
genl commands) in an future series.

v2: remove no-longer-unused csid variable (thanks Jakub)
    rebase on top of net-next
    use NLA_UINT for PN
v1: https://lore.kernel.org/netdev/cover.1664379352.git.sd@queasysnail.net/

Sabrina Dubroca (13):
  macsec: replace custom checks on MACSEC_SA_ATTR_AN with NLA_POLICY_MAX
  macsec: replace custom checks on MACSEC_*_ATTR_ACTIVE with
    NLA_POLICY_MAX
  macsec: replace custom checks on MACSEC_SA_ATTR_SALT with
    NLA_POLICY_EXACT_LEN
  macsec: replace custom checks on MACSEC_SA_ATTR_KEYID with
    NLA_POLICY_EXACT_LEN
  macsec: use NLA_POLICY_MAX_LEN for MACSEC_SA_ATTR_KEY
  macsec: use NLA_UINT for MACSEC_SA_ATTR_PN
  macsec: remove validate_add_rxsc
  macsec: add NLA_POLICY_MAX for MACSEC_OFFLOAD_ATTR_TYPE and
    IFLA_MACSEC_OFFLOAD
  macsec: replace custom checks on IFLA_MACSEC_ICV_LEN with
    NLA_POLICY_RANGE
  macsec: use NLA_POLICY_VALIDATE_FN to validate
    IFLA_MACSEC_CIPHER_SUITE
  macsec: validate IFLA_MACSEC_VALIDATION with NLA_POLICY_MAX
  macsec: replace custom checks for IFLA_MACSEC_* flags with
    NLA_POLICY_MAX
  macsec: replace custom check on IFLA_MACSEC_ENCODING_SA with
    NLA_POLICY_MAX

 drivers/net/macsec.c | 173 ++++++++++---------------------------------
 1 file changed, 38 insertions(+), 135 deletions(-)

-- 
2.50.0


