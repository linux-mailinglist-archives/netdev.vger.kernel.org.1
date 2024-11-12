Return-Path: <netdev+bounces-143966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AFE9C4E0E
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 06:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8539CB2098F
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 05:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113C7208208;
	Tue, 12 Nov 2024 05:09:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from r9133.ps.combzmail.jp (r9133.ps.combzmail.jp [49.212.13.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE1A1527A7
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 05:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.13.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731388155; cv=none; b=D0O6nXf4VCRldomYb+bMtr1JoaK2Fbzx4BdjbCXdcJq8i3NlQvN88tyWOGXAW+i8t41vEqnd4VAypQUoFIebTi0DK5MBxuqnFivcWW6e2ksTyAHBhwzK/nbdvqAV4pZ1VUs2FJcHnlD7P35bNeKqmuMPuQA63HxO+OvmhKKqA9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731388155; c=relaxed/simple;
	bh=St2rsNMTPgPgXM49JdqQRd8RX07V3iM4dbIFYfIxdcc=;
	h=To:From:Subject:Mime-Version:Content-Type:Message-Id:Date; b=amNxl6sX5zZ9BSvT+HZo1DYuut+CtPVHFmaic0p8mp2qTwrafDbU1pF7FStnPYmMRjlWsPqvWoTH1QfZccCiEqJPI0CFvIkklyw9fgwdCw1UiHEyIbCUEFs2hq6IlRG69N2ZI0TuHtFB93Xp8ObqJJMCIXFHpoJhmB0oPXbqV1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kb-company.site; spf=pass smtp.mailfrom=magerr.combzmail.jp; arc=none smtp.client-ip=49.212.13.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kb-company.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=magerr.combzmail.jp
Received: by r9133.ps.combzmail.jp (Postfix, from userid 99)
	id CA5D285932; Tue, 12 Nov 2024 14:08:51 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 r9133.ps.combzmail.jp CA5D285932
To: netdev@vger.kernel.org
From: info@kb-company.site<info@kb-company.site>
X-Ip: 5901201256590593
X-Ip-source: k85gj7ow48dnsahwu0p6gd
Precedence: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Subject: =?ISO-2022-JP?B?GyRCSyxGfDMwOXE/TSRyN2NBfSQ1JDskaxsoQg==?=
 =?ISO-2022-JP?B?U05TGyRCQG9OLBsoQg==?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-MagazineId: owhw
X-uId: 6762325043485867654165751015
X-Sender: CombzMailSender
X-Url: http://www.combzmail.jp/
Message-Id: <20241112050904.CA5D285932@r9133.ps.combzmail.jp>
Date: Tue, 12 Nov 2024 14:08:51 +0900 (JST)

いつもお世話になります。


中国のSNS「レッドブック」を活用した
店舗集客に役立つセミナーをご案内申し上げます。



　　　11月14日（木）／20日（水）14:00〜15:00
　　　オンラインセミナー

　　　◆　テーマ　◆
　　　中国人客を激増させるSNS戦略
　　　「レッドブック」対策
　　　――――――――――――――
　　　Googleビジネスプロフィールだけでは不十分？
　　　WEBからの集客を増やす
　　　“Googleビジネスプロフィール＋α”


　　　▼　詳細・お申込み　▼
　　　https://kb-company.biz/red-book/



中国の方が一番利用しているSNS

「レッドブック（小紅書）」

をご存知でしょうか。


レッドブックとは一言で言えば、中国語版のインスタグラムです。


商品の購入時や、飲食店、ホテル、美容・健康施設などを探す際に
参考にしたり、使用体験をシェアする場として使われます。


このような「自然な口コミ」の集合体を利用して、日本の事業者でも
レッドブックによる口コミ戦略で集客を増やすことができます。


実際にレッドブックの対策をしたお店は、

　◯大阪堺市のリサイクルショップ（免税売上金額）
　　対策前：30万/月　→　対策後：170万/月

　◯大阪市内のうなぎ店（インバウンド来客数）
　　対策前：0人/月　→　対策後：50人/月

と、顕著に効果が出ています。


また、レッドブックは観光で日本に渡航する中国人だけでなく
日本在住の中国人にも効果があるので、インバウンドに関係のない
事業者でも集客を増やすことができます。


中国人顧客を激増させるために、どんなレッドブック対策をすべきか？
オンラインセミナーにてお伝えしますので是非ご視聴ください。



　　　▼　詳細・お申込み　▼
　　　https://kb-company.biz/red-book/



□■□■□■□■□■□■□■□■□■□■□■□■□■□■

　 店舗WEB集客セミナー事務局
　 大阪市中央区本町2丁目3-9-5階
 　TEL　 06-6484-5302

□■□■□■□■□■□■□■□■□■□■□■□■□■□■
　本メールのご不要な方には大変ご迷惑をおかけいたしました。
　配信停止ご希望の方は、下記のフォームにて承っております。
　 https://kb-company.biz/mail/
　ページが表示されない場合は、このメールの件名を「配信停止」と
　変えてそのままご返信くださいませ。

