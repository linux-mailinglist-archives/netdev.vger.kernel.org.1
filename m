Return-Path: <netdev+bounces-245466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6842CCE4EC
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 04:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 664ED3026536
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 03:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEF01D6DA9;
	Fri, 19 Dec 2025 03:03:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from r9110.ps.combzmail.jp (r9110.ps.combzmail.jp [49.212.36.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A432BB17
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 03:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.36.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766113403; cv=none; b=WGTi3rvqOfGOmeCGpDpjEbwaVOM3A0so3qSsFw1SXT/uV0RL5MjZt6kr4OvwyQltrH32D+v/Zt4YAKqj3XtbMLtgAzpf3B5PputZvxS/bI1ZtZsOX+iDmpV7nQhD2fhQ7Izy2K9p57G4lh5J53RADdreNKY4VAhhbDDAjO0UY0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766113403; c=relaxed/simple;
	bh=rxdtig4WuSuZp/vzyTbggKH9HEirYly2qrtPpy17VQw=;
	h=To:From:Subject:Mime-Version:Content-Type:Message-Id:Date; b=uJmJxGdQ7vFTbvBhWrGLdTKHW6cqByCntHAXQLsLuHgAXIc5V+aMlNIvGK3v3irTGCY3DzL/1T8O46SPnh4eypE9o0GjkWA59xGlIaGq68TvSfnr/k3/uRHUcmPIl5+V+U57jMj3H21JpOcX0FYvj6UIyLAppi9VTNSOsGB6xNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onelife-lab.jp; spf=pass smtp.mailfrom=magerr.combzmail.jp; arc=none smtp.client-ip=49.212.36.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onelife-lab.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=magerr.combzmail.jp
Received: by r9110.ps.combzmail.jp (Postfix, from userid 99)
	id F25351892BD; Fri, 19 Dec 2025 12:02:47 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 r9110.ps.combzmail.jp F25351892BD
To: netdev@vger.kernel.org
From: =?ISO-2022-JP?B?GyRCJVolQyVISl04bjtZMWclOyVfJUohPBsoQg==?= <info@onelife-lab.jp>
X-Ip: 950673425849124
X-Ip-source: k85gj77948dnsa46u0p6gd
Precedence: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Subject: =?ISO-2022-JP?B?GyRCIVYlWiVDJUgwJiFXMG4kbCRrISI3UDFEGyhC?=
 =?ISO-2022-JP?B?GyRCPFRNTSRYGyhC?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-MagazineId: 7946
X-uId: 6763335740485968724370211011
X-Sender: CombzMailSender
X-Url: http://www.combzmail.jp/
Message-Id: <20251219030313.F25351892BD@r9110.ps.combzmail.jp>
Date: Fri, 19 Dec 2025 12:02:47 +0900 (JST)

　「ペット愛」溢れる、経営者様へ
　
　動物の尊い命を救い、働く喜びを支援する
　革新的な新規事業を始めませんか？

−−−−−−−−−−−−−−−−−−−−−−−
　■ フランチャイズシステム説明会 ■

　社会貢献と高収益を両立！

　ペット保護×就労継続支援B型事業
　”ONEPET（ワンペット）”

　※本部が徹底サポート！「経験や資格が無くても」
　　リスクを抑えて安心して始められます。

　■ 開催方式
　　オンライン（申込後に参加方法をご案内）

　■ 日程
　　12月17日（水）17：00〜18：30　満席
　　12月19日（金）16：00〜17：30　受付終了
　　12月26日（金）17：00〜18：30　残2枠
　
　■ 定員
　　各回4名 ／ 1社2名まで

　■ 視聴予約はこちら
   　https://onelife-pet.jp/onepet/
−−−−−−−−−−−−−−−−−−−−−−−
　
　お世話になります。
　
　この度は、「保護犬・猫」と「就労支援」を組み合わせた、
　革新的なフランチャイズ事業の説明会をご案内いたします。

　私たちがご提供する ONEPET（ワンペット） は、
　　「殺処分を待つ命を救う」
　　「働きたいと願う人々の自立を支援する」

　という、二つの大きな社会課題を同時に
　解決するビジネスモデルです。
　
　社会貢献事業は、収益がイマイチ。と、思わないでください。
　
　
　ONEPETでは、“動物と関わる”という圧倒的な差別化コンテンツを持つことで
　利用者から「やってみたい」と選ばれ、極めて高い集客力を誇ります。
　（オープン2ヶ月で400件超の問合せを達成）
　
　さらに、国の給付金によるストック型収益と
　ペット事業による店舗収益の二本柱で、
　景気に左右されにくい安定経営を実現しています。
　
　事実、年商7,000万円／営業利益率40％を目指せる高収益事業として、
　多くの経営者様にご注目いただいています。
　
　
　ここまでこの文章を読まれたということは、
　あなたも動物への深い愛情と、社会に貢献したいという
　強い意志をお持ちなのではないでしょうか。
　
　先輩FCオーナー様も福祉業界の経験がなくても、
　「定員満員までWeb広告費本部負担」
　「稼働率50％までロイヤリティ無料」
　
　といった、本部の手厚いサポートのもと
　事業を成功させています。
　
　この革新的なビジネスモデルの詳細を聞き逃さないよう、
　新規事業を探している経営者様は、この機会にぜひご視聴ください。
　
　
　「社会課題解決」と「安定収益」を両立する、
　新しい社会貢献のカタチを一緒につくっていきましょう。

■ 視聴予約はこちら
    https://onelife-pet.jp/onepet/

+++++++++++++++++++++++++++++++++++++++

本メールのご不要な方には大変ご迷惑をおかけいたしました。
お手数お掛けしますが、メール解除のお手続きは
下記よりお願いいたします。
<依頼フォーム>
https://onelife-pet.jp/mail/

+++++++++++++++++++++++++++++++++++++++

ONEPET（ワンペット）　フランチャイズ本部　
群馬県前橋市広瀬町3-18-15
TEL：080-7723-6089

