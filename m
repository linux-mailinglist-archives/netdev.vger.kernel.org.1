Return-Path: <netdev+bounces-292386-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOr1FmMdF2rw5AcAu9opvQ
	(envelope-from <netdev+bounces-292386-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:35:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA2E5E7D6E
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3BC313038BA5
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BFF42EEA0;
	Wed, 27 May 2026 16:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="kZjP96bb"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D844241B37F
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779899737; cv=none; b=ttcao2n5G64niyyGJpaRI8ngbTTrVqp8jqV3Qls/yuoAyE2RGWGB1oSxYsBbrHTeUoSmgy+C2kAAYfydogs+85rKVXkcuyKgeM5uaET6UU7My4ZwCa6bBM8XUz/UAbiDTsDuLG+36vpRAszGpz2ijy0Lo7Zeuujt0B+fMQVipHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779899737; c=relaxed/simple;
	bh=Fzc8xN6FmiUIrbJor/BDcOg8cja9xVyUqKoy63GHShA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YA6i8s/4DzK2iRnnnUMT3K0kzzaBaP+WEs9yK5D3AhvxuLbtn8lnis8+KS9X/vMTS6PvNDYKu19xO6OhnjEYUkGCX/YKICDWu9epo6K1E/5d8ZuyHclQSdfwQ8VJwZ6ftV0K9DPvzeiYXH+lgRWyUHaPWOe9ZiuBbUP4uU+Jw/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=kZjP96bb; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779899708; x=1780504508;
	i=markus.stockhausen@gmx.de;
	bh=y6YI3bU2GmzBc+4hvuxlfPwNmIHj67tOowpZ9RHSXWM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kZjP96bb3dw67x7R6k9+SrppDEObgLl5txhZBO0LmEoHeYsjt6T+6945tAWE7vRP
	 U/e2wxT9e306cPOu8mITEPg9kJ2LGl5pjKoW+H9RQTKw4OugiqdNbOVz/LCa3UZ//
	 kjNytEf+SevVRlAS1YPo0IyTABHDv/FNPoOA8VOuiDuTdcFw+dmPLgBtgoJefNKLp
	 Zi5d9209kCsCTLqgD0GiX5T6SSsZSHz4zkMp1R9D7A0EkXWJd9j4xoV2f2Y8IkGxI
	 g8/gLM+eBVgKCnPZbtU22c5kFf1Q9bmlAUvQ8ovrtaRmNSTTNeBIYmorOIoKS8Yyt
	 imTHmhyQ/lHIvauvng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUj2-1xIjU60GQs-00x6m6; Wed, 27
 May 2026 18:35:08 +0200
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
Subject: [PATCH net-next v2 3/4] net: mdio: realtek-rtl9300: use command runner for read_c45()
Date: Wed, 27 May 2026 18:34:48 +0200
Message-ID: <20260527163449.1294961-4-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527163449.1294961-1-markus.stockhausen@gmx.de>
References: <20260527163449.1294961-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rOjb57iGaSY+AB2MqtkoO9oNeiAMscbE7Ctu8n0WhCv1Wqy5JcA
 N+Ec9eQf9JEG3yByQqPzNFuEVBy187GaT0MVXrzDHP3YsRiMuWntd8pac98dN8VeeceYqap
 KcgK2gJaqNc0Whr0CJapn0eshlVZp8sopPi/pjcf13SentVBYXftKz3KIO9ZS7Vl/7f76Zq
 FLEe4tqw74+pDK2kRr4Ag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DPcXXEI+UDQ=;opKXB3RaIkv+b+uEUtWLbDuXFl3
 kuleakTBgaWucvIpkhPNEq29gSpyo0qkd8Pxx9+7DDLJxQFLbIEQs5noAPIkxdLJ8fLbQojm8
 6cG5v3scOgE/s4GlMk0kVq7D79Ivban/mh7Y60bJemhGWKXcmoOgeSfyMRpRIBXMpTxvceAK2
 hoRhx+evutMqyF03Hr0JB3rT/vo2wrobcpHRKFgClOzYC70zJ5z0wXbARxe9zgbqufq7lZb9n
 0q8qk9SaUHA/W0yDrytS+0qEwJFxYdUsDbYxamNd26Qao+ABLf1fUz7o/sjRU0TiNJyeUfyE1
 /h6T79ikH0xwgJsoNzNuhH6urPaIh8qRfxY+zqIP3p/6XWd0UY3uw4qHkmPb5TEoqxEeI6KMj
 nEBvGCyrAPtm/6Vbb0BbOilDrfUTiG5RrRNn15HKIZLBvFR+f4RDYBEsuzR2pehzEt9UmPeS0
 F2eqLjoe1xymos26nvtNyPWqzYLkFaI2uLdKak7T66hGMajuPcLOOEPH8RR2hVqdaVJuxq5uK
 WJC5dH+YWe172A0JLdICuUXr2wNuyS8DdIVb8vI5j9FBvAyvEPwakiSTknsWdhAqzMk6sGXW0
 xyfYRoWBGTXoOsiW9VL47rIJAunkEMmvLL9bJwm6zcJQeqVN+rev2gn6KdBIPM3vZseHo+nGn
 ZjUD3Z50GVuaWf/7sSMBt8uxO8MsFBfp4TDfm13K5Q/iqsRrrzC70tTYe0NmC98g025vlSh7x
 +m1DQcgB5gKN0tP3kC+iykEEL0pvwOD270I/hA+9AYT07+dcJVJTEtQ03IoGQZHkJ/nrBH9cW
 4fSmxRep9NFByI1/paWojwxSocqOecsAo+8yutOJ7nVNIUNTRbn3/ELnIWQPOgmKAjPHuwF67
 8ExNuEyH8u2wchq491sH/yy+Vv7bhB1rXxjoRBQNdDSwLvS4+UyrodswWiuJKuxIakQ47FSza
 X/Ka5H7RE2S3sE8kH7rVMyseHe7LonUMjulhBI8Wy+oyZVv1+e0k/HdlCZUDJzrNMTF7XYUG9
 6xTycBdaSPEOwTzIeYNQwRwsYc1zSIbQbBYaKin/SYyiwlJD7gwzODEhTS8K6vqxk635OEnm1
 2rthGLXxqShi6qeZgdwx8QFveUBHsaQcwjZGfBsRZ0cAoQUpJQuJgxizH69cF0g8I+1ElIG46
 dqUD7+2zIIWv8kVuNb+tMQ1+Z4DSM7AxeV8s93b0OGmqMsnr4262NoRw4utg6w8kXDDXPBfIC
 fNvfoqLXmtoOKDpt1aE9Y4HDorcdCwVwvxbWQsT6JEUKVyN5TseWuQR72o6PeXNUBjlXOljL5
 o6ZrkL7e5EmRNlkz8KrdjZ3+06ZkfB4CGGBTeDg5ikEDRx1GMjMw7a97dMW0EWm502vhpCcRA
 fb8JIYa39UQvpH8zC6tH2X0g1PdS/oyjd/bB3SFT1dFfhiX91jZiH0HDxn6uXhcS3aU3b8p5+
 nry3Vo0wkytkBMyL6/YMlax90T83GT8Q5Olifrid/dHib+/5s7e1T3b7it+J87cHSmaqqy3C0
 9uSEjZ1pUMkpLfiypRUFBjJw4ebuo1nCn/oXAPxBTx4WSFAF/6gXfYfni35jp/mOtVjQwsQ2F
 W3oVtR8ZqIfb/ENYs4xOZI8SSKIWJYFfFn9meSuxMaRX6vP3Xz9GR25bPAiqSe2THv77+dtUY
 RQeBCVUAUAOhAoAXM3UkFdD0NVO3ho0nUlA6NW9RJD3D56yCWVrowtV/B794aLhQTRtuUZ89a
 CkoM9jdOHyBs0rtGgNQ3qOxS1Xvw/zU/lBUg0m4v9+iD0kp7eoF91tBo4Quic6VJ91fGJal+1
 tjdu3ufbrvf9gkyX4koTFpfl3D++p9Y9IQQgAtLATY6abUmnMiq4SExbGke3OzUaxUA12N5TY
 3MtvVO3sNJv7KbSCvLwMnRxcQsYlT+N612S0zIX3XPGK0a/Puna12KosbTALRdlVYl0BeRNfj
 gginJDkeP/yjgawUow0LhnDCaasUl3hwBF2KeQ4Ofbg91B4bAsp/j6VyxkDXnAEMVvaJ1TSsX
 VyJhoMUzHANghd4EK10W9Kh38ltRqngm3R1gABGxRtNMy/L9sW8tFcKm4AC9JDRzMUvIu03cI
 gT+uyRpoaRxBuBKDoY/xTCkAZlvcF82pHWSXkQiBvgkiXyU8aKndnhmLe1Rcfj6x2vc0o+4kZ
 ftRjYAMPo6cEVJZj/cjaYfaRuesOQ6PE5uxlXjfeNLO00I9E0q2fg46KNr3DeQq3GII1ZaXUJ
 lYgqUYIgxBRnMeV5O3ZHGLwLFy8V+VaRgdZxrOFU4qLBL8zVdyeJOmbHQ+0cBgT9whajGTDRj
 gJB0yL9NzsbglELeEDwVOCr/rxbwFDYeBsnLsCMr30OYBRVLODTYmkzGu17P2djR1urtq3Oz7
 aBA9nGt60Qnt4omrUovh0MoV1FbSd3f+GqG5NfcZ/yB4gCMvR74Ug53XoLAZ2YQfFRPjsNT37
 IQ5lbfB8D9oceh0AXjGr64M2gfM1gVQqsg84RjJYiEdazyXmlBiREUGEBoZ8zsR+3TZfYd/xq
 1kN8pnTU4WXE/6SYb9U0yow24sK8RWX8y0uZeoJet0ScHOu7a5ehZ6kvkJqOfYtEVh3vRCJ8J
 yGv6ZWDCUQk9FDObBVi8pA45ANJB6+WMKBlyNi3cW0swVBsUmlf06IVA4IQTUMe8LNaueQjLW
 p6hAkc1ctDrXCt7r1AwSsHMp1uf9HJOv4YhHx5reMm0GO3woESfEmtLZxVo398gh6zYpAzGsP
 GLmadxWKqDDLNk76OgjN2U+0SLaBTZ7DkikGm/BZneGIIATMnV0Q6EYrzzAdUycEo4kVRhut8
 ymXDeiR9G3GKGLlrYvQJ8d379QdnMceawB2M9dx5iB5nwAAXk1elv0njuO8Zf5aQ4kVMBVAuf
 eUPygRt7KTnjvoAbPO/ODcd8lyOkmtD0Ntot8T8p2s2rjUss6KJKx+YwZ8MvJGHiYQgZO0SHi
 EZazaFdf3hrUw6WRc4RdQjrreocm/BQJpfoalJSlbnB+kauDyYZr8V5wUEOtmUvcDcI7HDE8W
 kJIVYyCv9ig4YFP8yKWEHuPyAF8ZAkcNgQovTSvvTj4qzBa1r39R0zWM13evhOz1HOOFjGC6K
 eXt3OmibCB690aVoN0mFPds0YzD8WZwLgOVHF8i3sBN8R87wSJG9ovrvNobUSd3ptmRAviwGl
 fqvdHRlT9d7UJTkHRy4QzM6Kjws/IjOX65LWZwvzd/qNt5w9Iqyu+EQnPMPJYwD7qDozErVG6
 JiA+X/SdbyNnj3oi0mzKko/cQ3tz546PKCGy1oQeIPNI7yQe/1OPddFy+ZWz/CJt5Y9POaqOO
 9K559+Cf3lp0wUNJ1RPWMGo43nZSMGL3NfBNokX5GzDyHy5rWrWJWf2us588f4T9N5WYgmULd
 Hf3sIbwcbiGDZY3aAVmBNwyqByYrFvfkY2FmHH8ENZUYF8nEA0zRJsudy448QgudnrOJHqs9D
 KzLzGPE0fkv7yBULgZbIWusKNtPhqFDKSQxbx1J9E0x+8DB4CfbQJpbdUiVWazVuMP4NW9o5w
 3sVbdtQ7mAo6+P9v8gUDMfCimn3DH+O5k4P7XNF/2He5MW+juC3bNyKFqA+v8qUS0I1ehYjis
 U//YM4ejXJrMvtzEHhKGCLAMCorKcLBSXuwrw6SnLIMI2OFHckCcQBjR2VuDmvX0BUWAye/Nz
 OvtfSsLjLf9bE+rFpwvbCpjhkAoRvtyxS7FKs8ouENBOdWXC5/ngJxZ7+P3bZFbQ93ZDtPYp7
 PHgHSjmcfjfJjDOwzj58hKj3Ak/cdE9Q2jZiuog4TU+9a6XHfNYuZVx6PL6R8amwytpuGpyJ+
 g1nomzeDr98aFxk7CEXZinmaqhwVyBTyHJcYtitDov9laEwOkP5NaXa+bRs0MbXXMVNKs8xvl
 DcH/ydx4yHnNXgtHcrKUkRsq/biDjzAdvfZ6MwYhZ9XN77WdltcmB8oQ4sDleKBB8t8SSpc9n
 F5Tw2A0RZTTkULKcrIRAIT7X1SnmIFBU2Pd3Jm1y+GjhKnuxN7TJRCFmN37GuN5zwDx+XWK98
 XcXv3cXX8InwG4EIo9HpwPEmwRCxzIHe3VFVNImOxWlDqnvdexE+EboHbvHtqjaqwDs6o6+1k
 3cxy5GcBASmRMRNgBp0Cir8IWsw0VBHSjEISW1HkJhBMIaferwHHOMNvO9WpL0pB1e+6tOdCd
 IKWJrssm4ELLWnb7mt3H7rMLLIuBKuC2p4Vaq7hMvrvP3FF8YVzPWZcBUAY9JE5l8KOWIh+A5
 2ksjEgS9cZhijABo30OJnJZdQ/09tQlVbi8kAB3vP87zi2kb8vuQddPJ+TptQhxGCNSyzULxq
 Mj6rxL5sl5bS+pDgYdZF8o7e0j/MWopyoKwT4DbKSlcRORn3dERrNyARNiZga+ViZC8x0XvM+
 osyekCe+Y8iYE1IGndgCbjDBp6s4KbMYVaBhhupibZa3oPlXCB6zz7MbjM3a7uOm+V/UVbUAg
 VGEUVKTcxMkUTPsNk2i6PMcU1gvxBFO6LuuUhnh1KhtefvDd5dPFExBkJh2cklqG8HyJ64sVy
 hD0GgzEsqlVt9KTNUX7u7chW4XigafQ2TfGvTw0fAUbm6AxqM7DosBrD03hHZuimRObYUosAH
 DH/e5NEQLrnjGM1HdJ2J6Mjg8k4WB6DusW1XUMSn2kX4nkhzky2ZalHNhAfz55ultSYuUabeb
 CXWQgQBgqWyeEIyzu2EaBl0a0wAogv9O4JwTT8sPesa8H20J+UJUKHFqwnQR+SlMhPmNoRCTi
 RZJacXHe3oca/Ft14XA36U00VBMOZmaaHwSIwwhf5IG+cI1h+jBmQmhTen6I02wgoRIKdHsLS
 lJRFxrGDK6F07DGckNxTqRFVioRX+0zY5MRk7CyCjR9G20YxFxpqw8eEbGMAhhYeLPamA56Ne
 4KRqlTA1hOlxS4tk6gQpYwjg9lJCSulKPjwfMiVFgrLlzKhd/U9bWLGax66MwsBYAmlaLNJGd
 tGfZMfpFUaPglSm/khO5KL5CdxQQqRgJ9DdAjtPHXsCR2j0L8xKkFjKJbZq72nrNkqfR+aY4g
 2B8hstJWQh3gzBhZSMPHVpZ07jSHMO6vd8akNbjUV71zqOG6JfBlYv3L7ot7/NyHdPt2bH3e2
 MzUfnkhzaxja/f5IfBT1z9/dA5+io33pXdLtkpwiPtisWCAOiir3h8uYxHOJ3HKD5NhdYsLpl
 /PTSRVN9QlkDRb5FwYW3H+6kZOVdfTRHydjOSMlvCCBbF44owG4BLeemQ1aqg4wNYkC2DyFBw
 F64CXXYmoLSp8eyFosrkr2W6KnsjbiJ3Uv49teJsE0CVgHYfhUG5C19hcbne2465LPFHmpWcJ
 lWty7dOQsLdFP3PG5TRP+WjOfWmLIEQ1nLATU66tkQ/o9kOKPja/X4v5tvaAnoOwe7Srwj72E
 X1kr83JtX3ahPSyN/fcyYBU4Q1ke0dvk9Qntp8owsyq36ZF+FmqEzrzFR1vaI6i7dNPA7p/WG
 rmBZixEvO/0MJgdND5mOY66m3m3RFL5f9vdacZ6WK9d/2Kvw9Ru2dBL5P7JIqYh2hvDG60jYX
 5s0+8g2JUDP8qYzUZMNZCQPDSgrvuiIIhJ7CRrkUuk8sSzcA44DrOLHEKxl56lqoGq4poxtn9
 LL72K/zSB8V4AO31i8=
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-292386-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,gmx.de:mid,gmx.de:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3BA2E5E7D6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert the read_c45() path to the new command runner. This needs the
additional helper otto_emdio_read_cmd() that can issue the command runner
and process a read operation. It is basically nothing more than

- run the command
- read the command result thorugh the I/O register

With this in place convert the read_c45() like the alread existing write
C22/C45 implementation.

- bus calls otto_emdio_read_c45()
- this handed over to SoC specific otto_emdio_9300_read_c45()
- the registers are filled
- the otto_emdio_read_cmd() is issued
- that calls the command runner

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 100 ++++++++++++------------
 1 file changed, 48 insertions(+), 52 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index e2685a169952..92d7fe6fa1f3 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -91,13 +91,14 @@ struct otto_emdio_cmd_regs {
=20
 struct otto_emdio_info {
 	u32 cmd_fail;
+	u32 cmd_read;
 	u32 cmd_write;
 	struct otto_emdio_cmd_regs cmd_regs;
 	u8 num_buses;
 	u8 num_ports;
 	u16 num_pages;
 	int (*read_c22)(struct mii_bus *bus, int phy_id, int regnum);
-	int (*read_c45)(struct mii_bus *bus, int phy_id, int dev_addr, int regnu=
m);
+	int (*read_c45)(struct mii_bus *bus, int port, int dev_addr, int regnum,=
 u32 *value);
 	int (*write_c22)(struct mii_bus *bus, int port, int regnum, u16 value);
 	int (*write_c45)(struct mii_bus *bus, int port, int dev_addr, int regnum=
, u16 value);
 };
@@ -182,6 +183,26 @@ static int otto_emdio_run_cmd(struct mii_bus *bus, u3=
2 cmd,
 	return cmdstate & info->cmd_fail ? -ENXIO : 0;
 }
=20
+static int otto_emdio_read_cmd(struct mii_bus *bus, u32 cmd,
+			       struct otto_emdio_cmd_regs *cmd_data, u32 *value)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	int ret;
+
+	lockdep_assert_held(&priv->lock);
+	ret =3D otto_emdio_run_cmd(bus, cmd | priv->info->cmd_read, cmd_data);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_read(priv->regmap, priv->info->cmd_regs.io_data, value);
+	if (ret)
+		return ret;
+
+	*value =3D FIELD_GET(PHY_CTRL_DATA, *value);
+
+	return 0;
+}
+
 static int otto_emdio_write_cmd(struct mii_bus *bus, u32 cmd,
 				struct otto_emdio_cmd_regs *cmd_data)
 {
@@ -268,58 +289,16 @@ static int otto_emdio_9300_write_c22(struct mii_bus =
*bus, int port, int regnum,
 	return otto_emdio_write_cmd(bus, PHY_CTRL_TYPE_C22, &cmd_data);
 }
=20
-static int otto_emdio_9300_read_c45(struct mii_bus *bus, int phy_id, int =
dev_addr, int regnum)
+static int otto_emdio_9300_read_c45(struct mii_bus *bus, int port,
+				    int dev_addr, int regnum, u32 *value)
 {
-	struct otto_emdio_chan *chan =3D bus->priv;
-	struct otto_emdio_priv *priv;
-	u32 io_reg, cmd_reg, val;
-	struct regmap *regmap;
-	int port;
-	int err;
-
-	priv =3D chan->priv;
-	regmap =3D priv->regmap;
-	io_reg =3D priv->info->cmd_regs.io_data;
-	cmd_reg =3D priv->info->cmd_regs.c22_data; /* shared command/C22 registe=
r */
-
-	port =3D otto_emdio_phy_to_port(bus, phy_id);
-	if (port < 0)
-		return port;
-
-	mutex_lock(&priv->lock);
-	err =3D otto_emdio_wait_ready(priv);
-	if (err)
-		goto out_err;
-
-	val =3D FIELD_PREP(PHY_CTRL_INDATA, port);
-	err =3D regmap_write(regmap, io_reg, val);
-	if (err)
-		goto out_err;
-
-	val =3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
-	      FIELD_PREP(PHY_CTRL_MMD_REG, regnum);
-	err =3D regmap_write(regmap, priv->info->cmd_regs.c45_data, val);
-	if (err)
-		goto out_err;
-
-	err =3D regmap_write(regmap, cmd_reg, PHY_CTRL_READ | PHY_CTRL_TYPE_C45 =
| PHY_CTRL_CMD);
-	if (err)
-		goto out_err;
-
-	err =3D otto_emdio_wait_ready(priv);
-	if (err)
-		goto out_err;
-
-	err =3D regmap_read(regmap, io_reg, &val);
-	if (err)
-		goto out_err;
-
-	mutex_unlock(&priv->lock);
-	return FIELD_GET(PHY_CTRL_DATA, val);
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c45_data	=3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
+				  FIELD_PREP(PHY_CTRL_MMD_REG, regnum),
+		.io_data	=3D FIELD_PREP(PHY_CTRL_INDATA, port),
+	};
=20
-out_err:
-	mutex_unlock(&priv->lock);
-	return err;
+	return otto_emdio_read_cmd(bus, PHY_CTRL_TYPE_C45, &cmd_data, value);
 }
=20
 static int otto_emdio_9300_write_c45(struct mii_bus *bus, int port,
@@ -350,6 +329,22 @@ static int otto_emdio_write_c22(struct mii_bus *bus, =
int phy_id, int regnum, u16
 	return ret;
 }
=20
+static int otto_emdio_read_c45(struct mii_bus *bus, int phy_id, int dev_a=
ddr, int regnum)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	int ret, port;
+	u32 value;
+
+	port =3D otto_emdio_phy_to_port(bus, phy_id);
+	if (port < 0)
+		return port;
+
+	scoped_guard(mutex, &priv->lock)
+		ret =3D priv->info->read_c45(bus, port, dev_addr, regnum, &value);
+
+	return ret ? ret : value;
+}
+
 static int otto_emdio_write_c45(struct mii_bus *bus, int phy_id,
 				int dev_addr, int regnum, u16 value)
 {
@@ -439,7 +434,7 @@ static int otto_emdio_probe_one(struct device *dev, st=
ruct otto_emdio_priv *priv
=20
 	bus->name =3D "Realtek Switch MDIO Bus";
 	if (priv->smi_bus_is_c45[mdio_bus]) {
-		bus->read_c45 =3D priv->info->read_c45;
+		bus->read_c45 =3D otto_emdio_read_c45;
 		bus->write_c45 =3D otto_emdio_write_c45;
 	} else {
 		bus->read =3D priv->info->read_c22;
@@ -561,6 +556,7 @@ static int otto_emdio_probe(struct platform_device *pd=
ev)
=20
 static const struct otto_emdio_info otto_emdio_9300_info =3D {
 	.cmd_fail =3D PHY_CTRL_FAIL,
+	.cmd_read =3D PHY_CTRL_READ,
 	.cmd_write =3D PHY_CTRL_WRITE,
 	.cmd_regs =3D {
 		.c22_data =3D RTL9300_SMI_ACCESS_PHY_CTRL_1,
=2D-=20
2.54.0


