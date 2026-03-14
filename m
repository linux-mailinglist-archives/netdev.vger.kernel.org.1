Return-Path: <netdev+bounces-267655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBPSNcustGllrwAAu9opvQ
	(envelope-from <netdev+bounces-267655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 01:33:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A12928AF6A
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 01:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60B14301EF11
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 00:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6891E1DFC;
	Sat, 14 Mar 2026 00:33:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from r9206.ps.combzmail.jp (r9206.ps.combzmail.jp [160.16.62.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F75C1D5170
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 00:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.16.62.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773448391; cv=none; b=sGJpyvhpeii1NMkSwcChNMkAcKxiJ76dleKCLp3PcFkmHzT4DI5lntiW8XY212GLdjL8Q3B5oj6zDU/sY2c3v8Dn/guAoo3axEGmO5cdBZRWC0PYNVZYuqsq97LC799f7650TdsPi789N0n54PWgbhC6j5N6JN0cTwBCiWzDAxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773448391; c=relaxed/simple;
	bh=gaxADsOpGh2R7TrfuYIbKk9k6zkvNv87ynFzd0C/yTc=;
	h=To:From:Subject:Mime-Version:Content-Type:Message-Id:Date; b=Ye7/yDl47/m5l+Ag/PL3CVsT4nFDdknXCJxe5Rd93ibT39CGp6iFLrfUgnt2m2unyeDiBuSSj2EbE1LmsV/8o4oMd1cVACHbpRKipXNSfuXXjY2WqyGvTvJP86qAk+M1iSj4Y7NQKk7YvBU0Wg5GJtXvpE1KiPajze6UKicKVJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=j-pet-hotel.jp; spf=pass smtp.mailfrom=magerr.combzmail.jp; arc=none smtp.client-ip=160.16.62.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=j-pet-hotel.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=magerr.combzmail.jp
Received: by r9206.ps.combzmail.jp (Postfix, from userid 99)
	id DFB3F103353; Sat, 14 Mar 2026 09:20:49 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 r9206.ps.combzmail.jp DFB3F103353
To: netdev@vger.kernel.org
From: =?ISO-2022-JP?B?GyRCRnxLXCVaJUMlSCVbJUYlazYoMnEbKEI=?= <info@j-pet-hotel.jp>
X-Ip: 3390141040952548
X-Ip-source: k85gj72w48dnsa51u0p6gd
Precedence: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Subject: =?ISO-2022-JP?B?GyRCJVolQyVIJHIwJiQ5JGshIjdQMUQ8VE1NGyhC?=
 =?ISO-2022-JP?B?GyRCJFgbKEI=?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-MagazineId: 2w51
X-uId: 6764245238486059665034691009
X-Sender: CombzMailSender
X-Url: http://www.combzmail.jp/
Message-Id: <20260314002114.DFB3F103353@r9206.ps.combzmail.jp>
Date: Sat, 14 Mar 2026 09:20:49 +0900 (JST)
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267655-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[j-pet-hotel.jp];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[info@j-pet-hotel.jp,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oneluke-fc-seminar.jp:url]
X-Rspamd-Queue-Id: 3A12928AF6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

　
　ペットを愛する、経営者様へ
　
　
　地域で愛犬を安心して預けられる
　ペットホテル・トリミング事業を始めませんか？
　
　
　■　フランチャイズシステム説明会　■
　
　　　愛犬家のオーナー多数！
　　　ペットホテル・トリミングサロン
　　　“ONE LUKE（ワンルーク）”
　
　　　※「開業パック」をご用意しているので
　　　　経験や資格が無くても始められます。
　
　
　■　開催方式
　　　オンライン（申込後に参加方法をご案内）
　
　■　日程
　　　3月16日（月）11:00〜12:00　残り1枠
　　　3月19日（木）15:00〜16:00　残り1枠
　　　3月24日（火）13:00〜14:00

　■　定員
　　　5名
　
　■　参加申込はこちら
　　　https://oneluke-fc-seminar.jp/lp/
　
　
　お世話になります。
　
　この度は、ペットホテル・トリミングサロンの
　フラチャイズ事業説明会の開催をご案内いたします。
　
　ペットホテルとトリミングサービスを提供する
　
　ONE LUKE（ワンルーク）
　
　は、ワンちゃんが好きすぎる創業者が実際に
　ペットホテルに預けたときに感じた不安や
　思ったことを施設づくりに活かしています。
　
　
　例えばワンちゃんが泊まるときに、少しでも
　広く、心地よく過ごして欲しいという思いから、
　鉄のゲージではなくオーダーで職人さんに
　「お部屋」をつくっていただいています。
　　
　そうした愛犬家目線のきめ細かいサービスが支持され、
　ワンルークを利用した方は高い確率でリピートしてくれます。
　
　
　日本ではいまや「8世帯に1世帯」がペットを飼うまでに
　増えてきましたが、ペットホテルはまだまだ店舗数が
　足りていないため、今後も成長が期待できます。
　
　
　ここまでこの文章を読まれたということは、
　あなたもワンちゃんが大好きなのではないでしょうか。
　
　ワンルークのFCオーナー様も愛犬家が多く、中には
　ご自身が利用者だった、という方もいらっしゃいます。
　
　
　説明会にて詳しいビジネスモデルをお伝えしますので、
　新規事業を探している愛犬家の経営者様は
　この機会にぜひご参加ください。
　
　
　地域のペットライフを豊かにし、愛犬が安心して
　過ごせる空間を一緒につくっていきましょう。
　
　
　■　フランチャイズシステム説明会　■
　
　　　愛犬家のオーナー多数！
　　　ペットホテル・トリミングサロン
　　　“ONE LUKE（ワンルーク）”
　
　■　参加申込はこちら
　　　https://oneluke-fc-seminar.jp/lp/
　
***********************************************************************
本メールのご不要な方には大変ご迷惑をおかけいたしました。
お手数お掛けしますが、メール不要のお手続きは
下記URLよりお願いいたします。
<メール停止フォーム>
　https://oneluke-fc-seminar.jp/mail/
***********************************************************************
日本ペットホテル協会株式会社
愛知県名古屋市千種区内山3丁目9-23 3F
TEL:052-784-8416
***********************************************************************

