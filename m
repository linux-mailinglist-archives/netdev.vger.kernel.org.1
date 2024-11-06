Return-Path: <netdev+bounces-142426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9079A9BF0F0
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 15:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA733B2273F
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 14:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDC41E767B;
	Wed,  6 Nov 2024 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sarinay.com header.i=@sarinay.com header.b="m+tJtfR+"
X-Original-To: netdev@vger.kernel.org
Received: from natrix.sarinay.com (natrix.sarinay.com [159.100.251.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03EB202F74
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.251.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905097; cv=none; b=DA5s/zsDa9Nr7eV+MMM+s2eihaUeVP5L3AqJWb5qRo9ymWaejNl3Harvj4vcuRlDvvnADOWdxHTN1qmsL+hhIDm2fJrNaj4K0Xuws6La5EBc3W7I1fqB873biUKYN4zADu6a7nJOY1uRwe7sfXGLexHD7uNSfck6SAzgyP5SGpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905097; c=relaxed/simple;
	bh=omvBOMsw8qm6Es20HBliwbCN7wg4thVyEJYyYQ3mDUM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AxkWx6l1MtLkeTS4Z49xANWY+6Kf4rgyQFdAQUoJF+japQ/DyexzyLACn/cgQjh6DUsEzebFLseULxpxUIc5qDHysrk7qZaWb5l7UHafCeqsx9xZrC8wjEhOrmakIAD+cdk8xtEoos+7c79F59N3knF3TjWFy4cOUAOqeTIBa38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sarinay.com; spf=pass smtp.mailfrom=sarinay.com; dkim=pass (2048-bit key) header.d=sarinay.com header.i=@sarinay.com header.b=m+tJtfR+; arc=none smtp.client-ip=159.100.251.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sarinay.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sarinay.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sarinay.com; s=2023;
	t=1730905088; bh=omvBOMsw8qm6Es20HBliwbCN7wg4thVyEJYyYQ3mDUM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=m+tJtfR+KU17Jki270CqsRohjZKeBWs3OdzLuKM/LaHdpQ+nW/pPIs5zduQO/MJ2G
	 4lmO5FNZYWB8lp2HYv0RRmAnmfPUwN+aL5ylI9BnYznsVvdueTll1KAt1I89KXGSz4
	 i7Zj24oKONLFnx9yJkzB7lT/vcXahFCErZsNVrHyL3dpQtVmhSI9rpcR93ps3owiBp
	 BKXjCJMUztJsOxNyYjL8oIojfAOFgywAG4tabPzJmRwKHqjEIthiEhqbZrGND4UPrB
	 7SL64Xp822uk7PyOZb9N1qXGT61ZzyWYl1t7/q0YqpLQsHUMYgzNbs119l8K5G9TWJ
	 gyOu4QABW9r7g==
Message-ID: <a0d73e24863106f477abba75b996f4b9ff00d737.camel@sarinay.com>
Subject: Re: [PATCH net-next v2] net: nfc: Propagate ISO14443 type A target
 ATS to userspace via netlink
From: Juraj =?UTF-8?Q?=C5=A0arinay?= <juraj@sarinay.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, krzk@kernel.org, kuba@kernel.org
Date: Wed, 06 Nov 2024 15:58:08 +0100
In-Reply-To: <20241106101804.GM4507@kernel.org>
References: <20241103124525.8392-1-juraj@sarinay.com>
	 <20241106101804.GM4507@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-06 at 10:18 +0000, Simon Horman wrote:
> > Add a 20-byte field ats to struct nfc_target and expose it as
> > NFC_ATTR_TARGET_ATS via the netlink interface. The payload contains
> > 'historical bytes' that help to distinguish cards from one another.
> > The information is commonly used to assemble an emulated ATR similar
> > to that reported by smart cards with contacts.
>=20
> Perhaps I misunderstand things, and perhaps there is precedence in relati=
on
> to ATR_RES. But I am slightly concerned that this leans towards exposing
> internal details rather then semantics via netlink.
>=20

Hi Simon

Thanks for the feedback. NFC_ATTR_TARGET_ATS would serve a similar
purpose as the following attributes the kernel already exposes (see
nfc.h):

 * @NFC_ATTR_TARGET_SENS_RES: NFC-A targets extra information such as NFCID
 * @NFC_ATTR_TARGET_SEL_RES: NFC-A targets extra information (useful if the
 *	target is not NFC-Forum compliant)
 * @NFC_ATTR_TARGET_NFCID1: NFC-A targets identifier, max 10 bytes
 * @NFC_ATTR_TARGET_SENSB_RES: NFC-B targets extra information, max 12 byte=
s
 * @NFC_ATTR_TARGET_SENSF_RES: NFC-F targets extra information, max 18 byte=
s
 * @NFC_ATTR_TARGET_ISO15693_DSFID: ISO 15693 Data Storage Format Identifie=
r
 * @NFC_ATTR_TARGET_ISO15693_UID: ISO 15693 Unique Identifier

The ATR I am after means "Answer To Reset" as defined in ISO 7816. It
has little to do with ATR_RES :=3D "Attribute Request Response" defined
in the NFC Digital specification. I only mentioned ATR_RES as the
source of the information handled by nci_store_general_bytes_nfc_dep(),
the function that motivated some of the code I propose to add.

Part 3 of the PC/SC Specification, Section 3.1.3.2.3 on ATR may perhaps
serve as a more authoritative source of motivation for the patch.

https://pcscworkgroup.com/Download/Specifications/pcsc3_v2.01.09.pdf

The goal is to access contactless identification cards via PC/SC.

	Juraj


