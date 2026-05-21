Return-Path: <netdev+bounces-290578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM9nO7JJD2ptIgYAu9opvQ
	(envelope-from <netdev+bounces-290578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:06:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F9F5AAC30
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C04C4301DCE3
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DF33F7A8A;
	Thu, 21 May 2026 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="eCB85vuE"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE2037DAAA
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386383; cv=none; b=VU+hjd7TspTltv99OKzMjN8O1dkkhV/v3ZalzNOaAYdUKeHHOnwzoPM90m4xucfkJ/5WisEHTO4fpHUnSkMGtZ8iKV4PQ5VFuW3jJ6OxRh+RnIG63eh4JuHfgaXwQaAgCqTh+U2BqGwkYMtkLjgiANWtGbEYxl0WYDSboODuvow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386383; c=relaxed/simple;
	bh=bdemff/c1wlZ9Q/Y7ycCSrjaE/doOy7Z4Y2Kypx1LIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EOx7n2Ewj+NH2MDNPdSkdNHB2n3MGPipMYTrJJXpfTYYFJFuBvRofDkjtFylvcNBIjEYCiQ8CsqtAX+W0NlAwVpshuO/d1C9PTtjlfg2h7rW98w2oQcEMoITCLTiYGeCvdLDSGZ0bBsxJz7VMJinJ3EVaj0/kEqY6TikJrj+upI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=eCB85vuE; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779386376; x=1779991176;
	i=markus.stockhausen@gmx.de;
	bh=b0/TAR5nXBZiEISzKlrdiaTaK8GA5tNbNemNmWDmnTA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eCB85vuEpJwXzDXXKllbs6Uozmso3QYFtZDN2n7fP8LAHpa6AXS7oGvHUAu6SHEY
	 sEEPKzdty2S5pvXGTsq90N9KOAhGaULRHSNTILlsEdzCW6talgh2qAMhB0gOqSjl6
	 b7QPvAtmc0fZ+zGArUEd934DbMfpyR8iYwtnNmw57PvOg0fY8X5H1EMaV8D/z+d61
	 6ALfkK9fSBof33TB/YvKqtkEuPt6cbCVVGiPQRytV8u7rQB9dvyNPUzavGWUFW81m
	 oy2P4Hz7wWYom+UBU36yJXnnnoEeI9Y/BBK2ZhenA9EIPa7xXbTpHo9E5zH0JDBPA
	 cpOOoGG1EwHP2WnaaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCbEf-1wY8RH2pUZ-007i4f; Thu, 21
 May 2026 19:59:36 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v2 4/9] net: mdio: realtek-rtl9300: Add pages to info structure
Date: Thu, 21 May 2026 19:59:13 +0200
Message-ID: <20260521175918.1494797-5-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521175918.1494797-1-markus.stockhausen@gmx.de>
References: <20260521175918.1494797-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6AFbYxuZpx1GE45sPxUOHVLqkyUuUWnIuDzPN4t511DShLsacbO
 8c+jJC7TP1ZIfoY+B8A+nqcuH5xGpbyDpNMF51ADLVdJxZ5R6kpLz6cE8C26nRRmKbHHlcv
 2xpZOv5Cf3XzREfMsKsP1+uTB2I/oJwBbNwWYByFFpxHwHhEw1bbucZmBE2EDZD3oWpEAwl
 qayPumXyGVF8HFtr21hLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W+BKVhZMnCQ=;646F3xOfFm4H9yG+zR+zMjlIwzg
 WRYJ9f77m5ufqbYvV0PNSh35+7G827yk57qlgUSeNxacuwcg1hfkINeEbV2syPXZAzaKPw+Cs
 kxE7DU6CiOpCI3qQwmlgbrE3OS9fg1bbTgOaVqJUKMkfyXtOJTXtoj7ze+v9avMp2WvvR3JFQ
 BJuUuLiFzhbHINf8iJGD6lfWX1/dZpAzWvV9wcgP+B4IOJOE/nKZNEIBTaao/BVQvYXlhV/2B
 ty7/9v9Fx5HvMn4PrzgZ23ycrci/xAu06n/s7N4Q0BIwG6W8Or6+tbDdmlawiwvAAtOohXjE8
 S7oUMMq4engZUUgKekKo3aMxNocQi3Wzui7S8aU75rNNxJ9RGbGWYp1FWkKDhQAGHRqsr8kqA
 OEx6n6/+K9psNorHudFwOxLKr05RA1m/7d3wVpDpYs6WTmaZW4zEtVACcUd0IYFvtuQlAXAn8
 K0pPDIoCdYYyPBKtMDDLiJwgBujTbb8U4z3+NNZWioR3AxY4Kjfpr6c9Peu2VLTsK5DEDrM6z
 fxrM1mGDX0L5iEgOKSWZarLb7Td+iO6BBAmpmLM4M8RXF0Tl0tnkgVYZs3snIHuT2O0cl7bI8
 ceV4yv4OZfgcdHFzwFTFjxXZGYW328PWCW1Unjet7uUFBqVRRgcpvxoXh9L6/S0mVSBupziey
 1R7P6/oeTRWu2QYFv8fL5YQ2d/BnNkGCECW51u/Q/VjCqHYHXWJu6pn7QkxzZZefFprNPB5Ss
 3wIBDfLlVDkSWxUzwkZr8CJWboLQp2mVCBNcWzLY16xhjTvVtudkBbkSRxboQyWwKyrDOgx6F
 MFORlLfH/omDVwZOmb8fc4iUjFWFaUGahDWYCciPHXw0L0uR4Pnhf7TdF+MJj9gwH44P+bMW3
 xTnql3lEkMMoMTO/J0xTZhkjq3CAvAHzS6Y1D7v1Zw72XPltfO1VYdWU7zmKn5Qkq1D4McDlA
 fmQLg7ICRZtdBOhe1EXC+PvByiVNexroTtHwWvV8vNaT8Dczkp5dRiMc4f8UR35Z5b70ayTMt
 OZDQL2qPTzeOH6u4hyB6oKiNWcodGa5EiisXJ5RVOnq3ZpiPAyPDvSdBp9pQNn1VPLSAlc4zB
 0JjWrVi+/RubR6DZDel6k4gMhhWWz6PwD5cIa7AmO5U4bMjLwY3+IO8EH3Cp5z+B/3llwotxG
 mpCVPD6FisYS8hVE/vemaPm9Fn+Bd5NnyslvPp83pXKmG0uoUkUB897xkMrYDWH6vgIMUsz/X
 2Y2/6hbMuB/pdtMBT6orgvdmJXCMZebxTFcrsH0JVjWGHNZzUOgZ2SFD45CCIAxcJTkMgCrIb
 X2/vYd58QsYKfGoMHWuqcPOSQ9pWv5Rgh5ssYXbJ7y50AITCCXn6lkXVLu1MwTLSDY+HV+JI1
 mmx0exAiDvnO15lBqRpxmRtgumfLq210gQ9tsuq60LK39FW4F7mdMyzrSPs51xlpK4+ZI/pz9
 ZsF8MldiH8VIJhZ2SlOPCjxGFeWzPyMv0Cqq45fvXCuf3HwCwYr7Hxpx4zFceyd7nlSsX8nPp
 cPhuVez6rY4b+akYkwUzNkGKRxyIwS5cGAIZ2QvHe2ESUA7fjUFIhmhwy6wlL/C5NqIMs4c3+
 /xrVRvXJNCjdqmTot3DeebCZvzgRGT3Le/gfQ9jqKElSohc5bxJlCZGWB05U0VuH4CmM8nSSE
 5d91ObuQs6BBHYNZl8d3yEZ/98keHoGb0z8mKjEZi2Z8/X5UkNNvFfrHp6iSn7NkGcarx0Z5S
 ECgcZQ03yQbFxRL8f7qVmNKms8tTjBxuu3iX81j+THrtW8neuNunGQ/Wle1Xp9c3HSNeqsZXP
 spmDeh7C4g4FrghABTICrKBZG2UydTwjT+T7nQDjxWA4EvNY45g0wA9hIBAdeedNofi24mIZL
 FrkYYNAVdauYyP0BV1pPNlrpwJ0ujiyWD4hxHWw4khqE1Muv+dC3dCfsE6pj9Xne8iNtV+sY9
 Hiw6xRghWn+68WvBwH2ygNM5bhfS8A+ELCq2ZgXlZc846ni+TYY4GfxBARSySHokVKe+WNlKF
 G5g7iLVMzKyfny7aTjkKB1YjHsBfz0R/FM9vHdbmO66xwMQH/3IFTW8yUyu+xNCbZ3rtp1wCr
 Pt6P8rqp5/c0GtUgqg25kU15kP6Qb8Gg0KTZoEUHMZ6ozzhZqlbSdSZHqGKpBzridr8aixzjO
 pwFq/RXoLpXnAuLy3BTDHDv93aQqlsECZO6p6BF/iyMD5oByVLgfQbxyLJ6vRrvtfOFRt3hhw
 nCA8puT8m/zOW+hXTmBtYkDq3PSbCHDvMe3J0jPMRDZqh/hHhFhaMjrhqL28Z+0NTdfpPs/7P
 tFKFEnFe7sd2bMQawWFCQjVSg38VSWqp0CPib648hg3nvNc9qcXA9+8snUAalNqtSwwUaKQsC
 JzYrGErbeUOp8LeEc8lDXwfQcvy4e+xy8Q0S9rPgw6TurCJ3tlLSbPvn3HOdN3r/eYao3TrWq
 ikc7CKMObkWFlGyPCn3IXU9VWw+VykT78uEZ0QX7Ing8rKoOh5e4gla0DlTZ5SLRIiVdNAJi0
 7u4gSdkg2O9IAIu6Th4900ogBj9HygisItmLLreSQbcpCkxu2oDLr99AwDWiu7GMZrl3+jW1n
 beZVRaLJx80LhyGndzMgb/94O94C4pnPhTUVsCKgG1RsMwt+bDMO4boM+ogy+6J9PdF+pTChD
 GKHrqbZWH3PYVPhmf8j7+iRrv3Fl3dhI9PCD53t9RG1QKpRUlL1NWuw0W42bJZdggT819002E
 om63yaUrXHb0zZqUn8B5rhnaooidmWmxGx49pXZGuOdTKtkbkI9QvJ5bxVgTUpji0IqPaKRFy
 Lsdwcl5aXmLiv2PziV2WrsT2Rt+sRSXC5vVxG8ECkj1WZMov+WT/ZWOKpN+5JDDWYo5RX7Xg/
 aGjUVYfC/CLh4O6eZmw16Zg4aOOBVTIoFZwXg0I1y6Az2fJAGpcIoEVXRuKZeZz4OOFMePaZn
 9Bhr3+yZ4gODjYsNTuWLupAdFix38F4O+JWbwKcljFclnkcjnn7VwypJq+2eYWEaHhPLHtLxS
 8tQJdlYfRHG7A9yC2XVdEajqzxMq4anPoVwRB+lYyqr7tFvGE1CHE8G/mkF65zaF3MYyUWdEl
 kePhiLXT7EB4ErKNgpO/9hhejPnYLCwJu2eHz9TsO7oTEFsvymzWOih5WZxuq0AZP+sf6Phj7
 8iWaGTcgOoZoVyrHg6cXMy7dKuDcGpZG97qBhKXsEtcFqrdmKFG/Ohmw2Om6tw/MkZW6NmDw5
 egJZnYQ1yFTcSBlofzismG4fwpWEnkQ51q4pDZFlaiWxR1OPf94Gx4GUUx4+/rKy6aq5oO1tu
 nIO9AeZGdcGkFS1v1ArJ9ijzDTLwUpQ2+SPC6RfKh3VgO0VLGfTpg83flFD3xi5zjE6mqQTcT
 0iJrmWRCHsqJnOx1i19C9L2ryRKvU4c9QpPqPVoVJdIY6PLBvYoXBzI9BDDJVYoUBXiFo3siY
 oiLJKNkLKPS5JshqHOzp5SL9/b/clqNdXl4yRMjBEwanrzmVZMSP8yqXMPMy7f0M0DfGGNhKz
 OoUB294lTMlQJaj6D6244Nl5/dBI6nQAVVhbPB3MbX6n7WbBmTo65lniMECGfKq6l/ZWLUifG
 qErCJlXnA6EPRbGal/8aK/xUebvqUHwJQXJ68T+6KncEEa9VuVBqPCsCp7xnS11v56fXZTSdN
 oPIuCLMc3TrUVWAJZj2hIvBRB2E6PQNrFCM4vjwbHpdKYKn8LCpIu5SZ6JnZUQJrm2Udh3mfy
 sxM3jy+eTgscUbRWsDWdtKhFEWXeCkYfvJyCXOMVR0A/+0ahkTUWAyyp1W8harXinijAQg0Jr
 Pkk/dF+ZCEAcyqG9jylZv0TOA9rtsqPbbLT4V92kh2WUbepQlTLT4AP/64fQRLQM2qZpNfZ0y
 OYvMynFgbHwIaQ8D2jXcGhknwobwlNzkQoEo/L7OehS0cC6Z7LR9T3gnd5dDEXc2v5Dhbrvg3
 r5O+3m9B+dn5n0Vba8iFYJYuV/Dp4hgVHByGdZaqzV3ZOZokszt7j1CBY7LcfEDWNeaWS2qFQ
 WwHqxDTZTc3i9VX5ioABBPriPx0nuXouSslryER2Oz+InLj3wEISFKSin1aZqE9SUk1CYuv1U
 37xvx8iM/H/D9oiXHdNjPhATEM12Jj7af++X2VZSRxJ/ohFHDZK7F6jXnYao4M3EU90I+dSe/
 IU5CKz7svj4fZHT0dGDrjtQOHOSB7rt7FjqnlzzOrQ+rE/i7ObDShtVjagg7fkh7lxPIYkLQM
 PQshvf3zpZmfctWhUdXy4B/gzK8vjHDoAZAYm0AugZhCuFrTr8dT0wOMr6+8srduk7WphmdXr
 gDDFfcgtBrMXxr5KAmBKubg2UQLctFf0oR0UMzVH77/9FTtwUmWLH4JDvsZxqlAmu+1nviPjM
 7sfAAQBx/Ne0Eppbnppw1DZ6mbVAyAjiFMoHGhQGZXK/fmj3KpRgaIVoXQmGVZMfAdk2GUUaR
 2pPoHIBLgztga5JO27GK82/b0yFKvTj32kJ+DIWN4ubsiSxGGup4EwoWtuUVcmcaGT6iqKGce
 +21xNmDr/exxc6Ku1uriMZ+qtu2azGuOSpaTqe0bPb/LS66Hx3/uhyfZ5oBUEyVfUk3SlbXLt
 6HiYh7eXP395a1/dUQtSAXs8mK0whhYZ9oEZy6N0blJ5TFzbpAw7i49OHkrLcTlzAabSaBEFD
 up54KrO06EfZnXr0FRcgt/XNpt5ut+oXTg48LHYlG896Yzfl2w3kELhDI3HRsOPaKDk9tsdZN
 Mb5yGqv8SCCC9955ufdMGVDdSWaUP01HOdirAgOW/Ob1wnwjNHCKzRbItL7Gnf+Kh+aTocFjt
 qdA/aujM3nDaJPSNwuXT0UsdiiR6xzNQV0Y0umP429x7rbtPE2WIFHKAhjXWblNOkn6mFw8DP
 7lhdvsyHlgz1hGB2GioMAuKO6KPy3OfIQcKQdARw/vTId9CEUK6RzKbral5QVPYGySspUuQFB
 BIKymYJkacrvKDVKW+PReMpsmqQ25VXI4XaaMpgLlM5rI+TeVLP5OwdpyT/Dkq+8MRNNewSSu
 7wS91TaqKJxXso69OBL4CtvXxLMsaLyZuY7VT1hdmt630XdGEDq2S3UfhAUiDQ8HBknM8n7+t
 /u1udPPbxOC2YDQHADq+GHLYqohw/Aw0ZEOUOIhVedMUOnecJSAd65IINCCKFBYWYfVN1WUkm
 FBttzc+IxxSqAjE7dNjNK0+yPTNndN4zY5jNzPI8C8bCKuI1vVRCaU4NOA57vZgmY0lTIBlq/
 35WRbbLxDEF9+tZobUBaMU8rFw98X4mznMxTAfXeseOgZJkqtgmvIT/8UqJeB95XcIbUnZf/f
 8FkRVpu79duMe29xp8chwD6iZP3UEQS5/AnszFgf2AQzmLRf/zt8QJsU/e5TfcYWpHEyDSCYv
 u//U4L6/pvaIR+DVjbn+GEWutD133KlXpaGfVDppSU/7iHcYQ/U9wOCooGG7lAJgvGzipClpT
 fN/sgLtfZ8obLgiLE6GYsRS4JwcvDSJ2IiE4KKPEe4hnDQrd262/CL02c1niNKPuO3Tvp08mm
 JJru9vxWZvxJEGco2eB3Z/7mOe72fpnRPAbkhMK7vyZWdGQo9LZ/g2RXQLnOwl0KE7QhHQJgS
 QqJSM+JvDGnFqBEx/bwyRkyAg4PrBDRTnNXOXRT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-290578-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Queue-Id: 47F9F5AAC30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Realtek ethernet MDIO controller has a proprietary paging feature
that is closely aligned with Realtek based PHYs. These PHY know "pages"
for C22 access. Those can be switched via reads/writes to register 31.
Usually the paged access must be programmed in four steps.

1. read/save page register
2. change "page" register 31
3. read/write data register (on the given page)
4. restore page register

The controller can run all this in hardware with one single request
from the driver. It is given the page, the register and the data
and takes care of all the rest. This reduces CPU load. The number
of supported pages depend on the model. This is either 4096 for low
port count SOCs (up to 28 ports) or 8192 for high port count SOCs
(up to 56 ports).

There is however one special page that allows to pass through all C22
commands directly to the PHY - without any caching. This so called raw
page is dependent of the hardware. It is the highest supported page
number minus 1.

Provide the number of supported pages as a device specific property.
This new "num_pages" aligns with the existing properties and gives
an better insight into the hardware layout than just defining the
number of the raw page. The later directly derives from that and
can be accessed with the new RAW_PAGE() macro. Make use of it where
needed.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 941e557bc0e2..94f59a56bc46 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -52,6 +52,7 @@
 #include <linux/regmap.h>
=20
 #define RTL9300_NUM_BUSES		4
+#define RTL9300_NUM_PAGES		4096
 #define RTL9300_NUM_PORTS		28
 #define SMI_GLB_CTRL			0xca00
 #define   GLB_CTRL_INTF_SEL(intf)	BIT(16 + (intf))
@@ -78,10 +79,12 @@
 #define MAX_PORTS       28
 #define MAX_SMI_BUSSES  4
 #define MAX_SMI_ADDR	0x1f
+#define RAW_PAGE(priv)	((priv)->info->num_pages - 1)
=20
 struct otto_emdio_info {
 	u8 num_buses;
 	u8 num_ports;
+	u16 num_pages;
 };
=20
 struct otto_emdio_priv {
@@ -154,7 +157,7 @@ static int otto_emdio_9300_read_c22(struct mii_bus *bu=
s, int phy_id, int regnum)
=20
 	val =3D FIELD_PREP(PHY_CTRL_REG_ADDR, regnum) |
 	      FIELD_PREP(PHY_CTRL_PARK_PAGE, 0x1f) |
-	      FIELD_PREP(PHY_CTRL_MAIN_PAGE, 0xfff) |
+	      FIELD_PREP(PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)) |
 	      PHY_CTRL_READ | PHY_CTRL_TYPE_C22 | PHY_CTRL_CMD;
 	err =3D regmap_write(regmap, SMI_ACCESS_PHY_CTRL_1, val);
 	if (err)
@@ -207,7 +210,7 @@ static int otto_emdio_9300_write_c22(struct mii_bus *b=
us, int phy_id, int regnum
=20
 	val =3D FIELD_PREP(PHY_CTRL_REG_ADDR, regnum) |
 	      FIELD_PREP(PHY_CTRL_PARK_PAGE, 0x1f) |
-	      FIELD_PREP(PHY_CTRL_MAIN_PAGE, 0xfff) |
+	      FIELD_PREP(PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)) |
 	      PHY_CTRL_WRITE | PHY_CTRL_TYPE_C22 | PHY_CTRL_CMD;
 	err =3D regmap_write(regmap, SMI_ACCESS_PHY_CTRL_1, val);
 	if (err)
@@ -540,6 +543,7 @@ static int otto_emdio_probe(struct platform_device *pd=
ev)
 static const struct otto_emdio_info otto_emdio_9300_info =3D {
 	.num_buses =3D RTL9300_NUM_BUSES,
 	.num_ports =3D RTL9300_NUM_PORTS,
+	.num_pages =3D RTL9300_NUM_PAGES,
 };
=20
 static const struct of_device_id otto_emdio_ids[] =3D {
=2D-=20
2.54.0


